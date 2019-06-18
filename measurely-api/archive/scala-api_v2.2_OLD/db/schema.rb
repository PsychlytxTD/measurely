# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_04_063417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "analytics_posttherapies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "clinician_id"
    t.uuid "client_id"
    t.string "first_name"
    t.string "last_name"
    t.string "sex"
    t.string "birth_date"
    t.string "postcode"
    t.string "marital_status"
    t.string "sexuality"
    t.string "ethnicity"
    t.string "indigenous"
    t.string "children"
    t.string "workforce_status"
    t.string "education_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "client_id"
    t.string "first_name"
    t.string "last_name"
    t.string "sex"
    t.string "birth_date"
    t.string "postcode"
    t.string "marital_status"
    t.string "sexuality"
    t.string "ethnicity"
    t.string "indigenous"
    t.string "children"
    t.string "workforce_status"
    t.string "education"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "clinician_id"
  end

  create_table "clinician", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "clinician_id"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posttherapy_analytics", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "clinician_id"
    t.uuid "client_id"
    t.string "principal_diagnosis"
    t.string "secondary_diagnosis"
    t.string "attendance_schedule"
    t.integer "non_attendances"
    t.integer "attendances"
    t.integer "out_of_pocket"
    t.string "premature_dropout"
    t.string "therapy"
    t.string "funding"
    t.string "referrer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scale", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "client_id"
    t.string "measure"
    t.string "subscale"
    t.string "date"
    t.integer "score"
    t.float "pts"
    t.float "se"
    t.float "ci"
    t.float "ci_upper"
    t.float "ci_lower"
    t.float "mean"
    t.string "mean_reference"
    t.float "sd"
    t.string "sd_reference"
    t.float "reliability"
    t.string "reliability_reference"
    t.float "confidence"
    t.string "method"
    t.string "population"
    t.string "cutoff_label_1"
    t.string "cutoff_label_2"
    t.string "cutoff_label_3"
    t.string "cutoff_label_4"
    t.string "cutoff_label_5"
    t.float "cutoff_value_1"
    t.float "cutoff_value_2"
    t.float "cutoff_value_3"
    t.float "cutoff_value_4"
    t.float "cutoff_value_5"
    t.string "cutoff_reference_1"
    t.string "cutoff_reference_2"
    t.string "cutoff_reference_3"
    t.string "cutoff_reference_4"
    t.string "cutoff_reference_5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "clinician_id"
  end

end
