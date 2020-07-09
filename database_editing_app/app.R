# Demo DataTable + postgres in Shiny
#
#----------------------------------------
# Load libraries
library(shiny)
library(DT)
library(pool)
library(DBI)
library(RPostgreSQL)
library(dplyr)
library(glue)


if(packageVersion("DT")<"0.2.30"){
    message("Inline editing requires DT version >= 0.2.30. Installing...")
    devtools::install_github('rstudio/DT')
}

if(packageVersion("glue")<"1.2.0.9000"){
    message("String interpolation implemented in glue version 1.2.0 but this version doesn't convert NA to NULL. Requires version 1.2.0.9000. Installing....")
    devtools::install_github('tidyverse/glue')
}


#Hardcode clinician id for now

clinician_id<- "af7c5ab1-a862-466d-9e56-98580891db9f" 



#----------------------------------------
# helpers.R
# Define function that updates a value in DB
# updateDB(editedValue, pool, tbl)
updateDB <- function(editedValue, pool, tbl){
    # Keep only the last modification for a cell
    editedValue <- editedValue %>% 
        group_by(row, col) %>% 
        filter(value == dplyr::last(value)| is.na(value)) %>% 
        ungroup()
    
    conn <- poolCheckout(pool)
    
    lapply(seq_len(nrow(editedValue)), function(i){
        temp_id = editedValue$row[i]
        col = dbListFields(pool, tbl)[editedValue$col[i]]
        value = editedValue$value[i]
        
        query <- glue::glue_sql("
                          ALTER TABLE {`tbl`}
                          ADD COLUMN temp_id SERIAL;
                          UPDATE {`tbl`} SET
                          {`col`} = {value}
                          WHERE temp_id = {temp_id};
                          ALTER TABLE {`tbl`}
                          DROP temp_id;
                          ", .con = conn)
        
        dbExecute(conn, sqlInterpolate(ANSI(), query))
    })
    
    poolReturn(conn)
    print(editedValue)  
    return(invisible())
}



#---------------------------------------- shiny
# Define pool handler by pool on global level
pool <- dbPool( #Set up the connection with the db
    drv = dbDriver("PostgreSQL"),
    dbname = "postgres",
    host = Sys.getenv("DBHOST"),
    user = Sys.getenv("DBUSER"),
    password = Sys.getenv("DBPASSWORD")
)

onStop(function() {
    poolClose(pool)
}) # important!

#----------------------------------------
# Define UI 
ui <- fluidPage(
    
    tags$head( 
        
        includeCSS(file.path(".", "styling.css"))
        
    ),
    
    # Application title
    titlePanel("Update Your Details"),
    
    sidebarLayout(
        sidebarPanel(
            width = 2,
            helpText("Edit basic information about yourself,
            your practice, and your clients. Double click on a cell, edit the value, and then
            click anywhere outside the cell. Save and Cancel buttons will then appear to either
            submit or cancel the changes. To delete an outcome measure assessment, navigate
            to the second tab, select a client and then follow the prompts for deletion."),
            uiOutput("buttons_record"),
            uiOutput("buttons_clinician"),
            uiOutput("buttons_scale")
        ),
        mainPanel(
            tabsetPanel(
                tabPanel(p("Edit Basic Information", class = "my_class_test"), br(),
                         
                         selectizeInput(
                             inputId = "db_table_selection",
                             label = "",
                             choices = list("Clinician Information" = "clinician", "Practice Details" = "practice", 
                                            "Client Information" = "client")),
                         
                         
                         DT::dataTableOutput("record")),
                tabPanel("Delete Outcome Measure Administrations", 
                         br(), 
                         div(uiOutput("client_dropdown"),  actionButton("select_record", "Select Client", class = "submit_button")),
                         br(),
                         uiOutput("scale_entry_dropdown"),
                         br(),
                         DT::dataTableOutput("entries_table"),
                         br(),
                         actionButton("delete_entry", "Delete Entry", class = "submit_button")
                         #
                )
            )
        )
    )
)
#----------------------------------------
# Define server
server <- function(input, output, session) {
    
    rvs_record <- reactiveValues(
        data = NA, 
        dbdata = NA,
        dataSame = TRUE,
        editedInfo = NA
    )
    
    #-----------------------------------------  
    # Generate source via reactive expression
    mysource_record<- reactive({
        
        record<- pool %>% tbl(req(input$db_table_selection)) %>% collect() #%>% 
        # dplyr::select(contains("first_name"), contains("last_name"), 
        #contains("email_address"), contains("name"), contains("postcode"),
        #contains("location"))
        
    })
    
    # Observe the source, update reactive values accordingly
    observeEvent(mysource_record(), {
        
        # Lightly format data by arranging id
        # Not sure why disordered after sending UPDATE query in db    
        data <- mysource_record() #%>% arrange(first_name, last_name, birth_date)
        
        rvs_record$data <- data
        rvs_record$dbdata <- data
        
    })
    
    #-----------------------------------------
    
    #clinician_cols<- c(0,1,2,3,7,8,9,10,11,12,13,14)
    #practice_cols<- c(1)
    #client_cols<- c(0,1,2,3,4,8,9,10,11,12,13,14,15,16,17)
    
    
    # Render DT table and edit cell
    # 
    # no curly bracket inside renderDataTable
    # selection better be none
    # editable must be TRUE
    output$record <- DT::renderDataTable(
        
        
        rvs_record$data, rownames = FALSE, editable = TRUE, selection = 'none',
        colnames = if(input$db_table_selection == "practice") {
            c("Practice Name"="name", "Practice Type" = "type", "Practice Location" = "location")} else {
                c("First Name" = "first_name", "Last Name" = "last_name","Email Address" = "email_address")},
        options=list(columnDefs = list(list(visible=FALSE, targets = 
                                                if(input$db_table_selection == "clinician") {
                                                    c(0,1,2,3,7,8,9,10,11,12,13,14)
                                                } else if(input$db_table_selection == "practice") {
                                                    c(1)
                                                } else {
                                                    c(0,1,2,3,4,8,9,10,11,12,13,14,15,16,17)
                                                })),
                     initComplete = JS(
                         "function(settings, json) {",
                         "$(this.api().table().header()).css({'background-color': '#e5e5e5', 'color': '#d35400'});",
                         "}"))
    )
    
    proxy_record = dataTableProxy('record')
    
    observeEvent(input$record_cell_edit, {
        
        info = input$record_cell_edit
        
        i = info$row
        j = info$col = info$col + 1  # column index offset by 1
        v = info$value
        
        rvs_record$data[i, j] <<- DT::coerceValue(v, dplyr::pull(rvs_record$data[i, j]))
        replaceData(proxy_record, rvs_record$data, resetPaging = FALSE, rownames = FALSE)
        
        rvs_record$dataSame <- identical(rvs_record$data, rvs_record$dbdata)
        
        if (all(is.na(rvs_record$editedInfo))) {
            rvs_record$editedInfo <- data.frame(info, stringsAsFactors = FALSE)
        } else {
            rvs_record$editedInfo <- dplyr::bind_rows(rvs_record$editedInfo, data.frame(info, stringsAsFactors = FALSE))
        }
        
    })
    
    #-----------------------------------------
    # Update edited values in db once save_record is clicked
    observeEvent(input$save_record, {
        
        updateDB(editedValue = rvs_record$editedInfo, pool = pool, tbl = input$db_table_selection)
        
        rvs_record$dbdata <- rvs_record$data
        rvs_record$dataSame <- TRUE
        
        shinyWidgets::sendSweetAlert(
            session = session,
            title = "Success !!",
            text = "Your change has been saved.",
            type = "success"
        )
        
    })
    
    #-----------------------------------------
    # Oberve cancel_record -> revert to last save_recordd version
    observeEvent(input$cancel_record, {
        rvs_record$data <- rvs_record$dbdata
        rvs_record$dataSame <- TRUE
        
        shinyWidgets::sendSweetAlert(
            session = session,
            title = "That Wasn't Right!!",
            text = "Your change has been cancelled.",
            type = "error"
        )
    })
    
    #-----------------------------------------
    # UI buttons_record
    output$buttons_record <- renderUI({
        div(
            if (! rvs_record$dataSame) {
                span(
                    actionButton(inputId = "save_record", label = "Save",
                                 class = "btn-primary"),
                    actionButton(inputId = "cancel_record", label = "Cancel")
                )
            } else {
                span()
            }
        )
    })
    
    
    #########################################################################
    
    
    records<- reactive({
        
        # Querying code to be called when clinician clicks 'existing record' tab further down. To generate dropdown of records.
        
        record_list_sql<- "SELECT clinician_id, id, first_name, last_name, birth_date
                           FROM client
                           WHERE clinician_id = ?clinician_id;"
        
        record_list_query<- sqlInterpolate(pool, record_list_sql, clinician_id = clinician_id)
        
        record_list<- dbGetQuery( pool, record_list_query )
        
        validate(need(length(record_list) >= 1, "No records registered yet."))
        
        record_list$birth_date<- as.character(format(record_list$birth_date, "%d/%m/%Y")) #Make sure date appears in correct format (i.e. day, month, year)
        
        record_list <- record_list %>%
            tidyr::unite(dropdown_record, first_name, last_name, birth_date, sep = " ", remove = FALSE)
        
        record_list<- record_list %>%
            collect  %>%
            split( .$dropdown_record ) %>%    # Field that will be used for the labels
            purrr::map(~.$id)          #Field that will be returned when the clinician actually chooses the record
        
        
    })
    
    
    
    output$client_dropdown<- renderUI({ #Make the record selection widget
        
        req(records())
        
        selectizeInput(
            inputId = "client_selection",
            label = "",
            choices = records(),
            options = list(
                placeholder = 'Select A Client..',
                onInitialize = I('function() { this.setValue(""); }')
            ))
        
    })
    
    outputOptions(output, "client_dropdown", suspendWhenHidden = FALSE)
    
    
    
    
    selected_record_data <-eventReactive( input$select_record,
                                          {
                                              
                                              
                                              scale_entry_sql <- 
                                                  "SELECT entry_id, date, measure
                FROM scale
                WHERE client_id = ?client_id;"
                                              
                                              scale_entry_query <-sqlInterpolate(pool, scale_entry_sql, 
                                                                                 client_id = input$client_selection)
                                              
                                              scale_entries<- dbGetQuery(pool, scale_entry_query) %>% dplyr::distinct(entry_id, .keep_all = TRUE)
                                              
                                              scale_entry_list <- scale_entries %>%
                                                  tidyr::unite(dropdown_scale_entry, date, measure, sep = " ", remove = FALSE)
                                              
                                              scale_entry_list<- scale_entry_list %>%
                                                  collect  %>%
                                                  split( .$dropdown_scale_entry) %>%    # Field that will be used for the labels
                                                  purrr::map(~.$entry_id)          #Field that will be returned when the clinician actually chooses the record
                                              
                                              
                                          })
    
    
    output$scale_entry_dropdown<- renderUI({ #Make the record selection widget
        
        req(records())
        
        selectizeInput(
            inputId = "scale_entry_selection",
            label = "",
            choices = selected_record_data(),
            options = list(
                placeholder = 'Select Assessment Entry to Delete',
                onInitialize = I('function() { this.setValue(""); }')
            ))
        
    })
    
    outputOptions(output, "scale_entry_dropdown", suspendWhenHidden = FALSE)
    
    
    
    entry_to_display<- reactive({
        
        req(input$scale_entry_selection)
        
        scale_display_sql <- 
            "SELECT entry_id, date, measure, subscale, score
             FROM scale
             WHERE entry_id = ?entry_id;"
        
        scale_display_query <-sqlInterpolate(pool, scale_display_sql, 
                                             entry_id = input$scale_entry_selection)
        
        scale_display_table<- dbGetQuery(pool, scale_display_query)
        
        
        scale_display_table %>% dplyr::select(date, measure, subscale, score) %>%
            dplyr::rename_all(toupper) %>% dplyr::mutate(MEASURE = gsub("_", " ", MEASURE),
                                                         SUBSCALE = gsub("_", " ", SUBSCALE),
                                                         DATE = as.character(format(DATE, "%d/%m/%Y")))
        
    })
    
    
    output$entries_table<- renderDataTable({
        
        DT::datatable(
            
            entry_to_display(),
            extensions = 'Scroller', rownames = FALSE,
            options = list(initComplete = JS(
                "function(settings, json) {",
                "$(this.api().table().header()).css({'background-color': '#e5e5e5', 'color': '#d35400'});",
                "}"), deferRender = TRUE, scrollY = 200, scroller = TRUE, dom = "t" )
            
        )
        
        
    })
    
    
    
    
    observeEvent(req(input$delete_entry), {
        
        
        conn<- poolCheckout(pool)
        
        
        delete_scale_entry_query<- glue::glue_sql("DELETE FROM scale
                                         WHERE entry_id = { input$scale_entry_selection }", 
                                                  .con = conn)
        
        dbExecute(conn, sqlInterpolate(ANSI(), delete_scale_entry_query))
        
        
        delete_item_entry_query<- glue::glue_sql("DELETE FROM item
                                             WHERE entry_id = { input$scale_entry_selection }", 
                                                 .con = conn)
        
        dbExecute(conn, sqlInterpolate(ANSI(), delete_item_entry_query))
        
        
        poolReturn(conn)
        
        shinyWidgets::sendSweetAlert(
            session = session,
            title = "Success !!",
            text = "This entry has been deleted.",
            type = "success"
        )
        
        
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
