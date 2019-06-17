---
title: "Psychlytx"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


I have set up a skeleton pacakge with one function, defined in `/R/calcs.R`. This skeleton is enough for you to build and use `library(psychlytx)` in your apps. But you'll need to add other functions, documentation and tests for it to actually be useful.

## Building a package

1. Open the psychlytx.Rproj file
2. Install `library(roxygen2)` if you haven't already done so
3. Go to `Build > Configure Build Tools` 
  - check 'Generate Documentation with Roxygen'
  - press 'Configure' (this may open automatically when you check the box)
  - check all boxes
  - This means whenever you build your package, all the documentation gets compiled and written
2. To build the package in RStudio press Ctrl + Shift + B
  - If it succeeds you'll be able to call `library(psychlytx)`
  - If it fails, fix the errors and try again
  
## Testing a package

1. Install `library(testthat)` 
2. Test your build by running `devtools::test()`
  - If it fails you will usually fix the code, rather than change the tests. The tests should remain constant for all time.
  - You can add tests inside the `/tests/testthat` folder
3. You want to test your functions correctly produce the right output, and handle any errors (such as division by 0, etc)  

[library(testthat) documentation is here](https://testthat.r-lib.org/)

[A good article on how to use it is here](http://r-pkgs.had.co.nz/tests.html) (written by Hadley)
  
## Checking a package

1. Check your pacakge is 'valid' using `devtools::check()`
  - This is necessary if you want to upload to CRAN. However, even if you don't, it's good practice as it tells you if your documentation is correct, your variables are defined etc.

## Documenting a package

[roxygen2 information is here](https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html)

1. With `roxygen2` installed you can add comments above your functions using the `#'` syntax
2. These comments get parsed by roxygen and turned into the help files you see when you use `?`. For example, after building this package you can use `?t_rel`, and the help page will be shown (currently incomplete)


---

## Reactive Values

I've also added a brief note of `reactiveValues()` to the PHQ9 `server` function. [Here](https://riptutorial.com/shiny/example/32342/reactivevalues) is a good example of them in use





