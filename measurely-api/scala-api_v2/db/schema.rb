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

ActiveRecord::Schema.define(version: 2019_08_11_074558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "client", id: :text, force: :cascade do |t|
    t.datetime "creation_date", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "update_date", default: -> { "CURRENT_TIMESTAMP" }
    t.text "clinician_id", null: false
    t.text "first_name", null: false
    t.text "last_name", null: false
    t.text "email_address", null: false
    t.date "birth_date", null: false
    t.text "sex"
    t.text "postcode"
    t.text "marital_status"
    t.text "sexuality"
    t.text "ethnicity"
    t.boolean "indigenous"
    t.integer "children"
    t.text "workforce_status"
    t.text "education"
  end

  create_table "holding", id: :text, force: :cascade do |t|
    t.datetime "creation_date", default: -> { "CURRENT_TIMESTAMP" }
    t.text "clinician_id", null: false
    t.text "client_id", null: false
    t.text "measure", null: false
    t.text "subscale", null: false
    t.float "mean", null: false
    t.text "mean_reference", null: false
    t.float "sd", null: false
    t.text "sd_reference", null: false
    t.float "reliability", null: false
    t.text "reliability_reference", null: false
    t.float "confidence", null: false
    t.text "method", null: false
    t.text "population", null: false
    t.text "cutoff_label_1", null: false
    t.text "cutoff_label_2", null: false
    t.text "cutoff_label_3", null: false
    t.text "cutoff_label_4", null: false
    t.text "cutoff_label_5", null: false
    t.text "cutoff_label_6", null: false
    t.float "cutoff_value_1", null: false
    t.float "cutoff_value_2", null: false
    t.float "cutoff_value_3", null: false
    t.float "cutoff_value_4", null: false
    t.float "cutoff_value_5", null: false
    t.float "cutoff_value_6", null: false
    t.text "cutoff_reference_1", null: false
    t.text "cutoff_reference_2", null: false
    t.text "cutoff_reference_3", null: false
    t.text "cutoff_reference_4", null: false
    t.text "cutoff_reference_5", null: false
    t.text "cutoff_reference_6", null: false
  end

  create_table "item", id: :text, force: :cascade do |t|
    t.datetime "creation_date", default: -> { "CURRENT_TIMESTAMP" }
    t.text "clinician_id", null: false
    t.text "client_id", null: false
    t.date "date", null: false
    t.text "measure", null: false
    t.text "item_1"
    t.text "item_2"
    t.text "item_3"
    t.text "item_4"
    t.text "item_5"
    t.text "item_6"
    t.text "item_7"
    t.text "item_8"
    t.text "item_9"
    t.text "item_10"
    t.text "item_11"
    t.text "item_12"
    t.text "item_13"
    t.text "item_14"
    t.text "item_15"
    t.text "item_16"
    t.text "item_17"
    t.text "item_18"
    t.text "item_19"
    t.text "item_20"
    t.text "item_21"
    t.text "item_22"
    t.text "item_23"
    t.text "item_24"
    t.text "item_25"
    t.text "item_26"
    t.text "item_27"
    t.text "item_28"
    t.text "item_29"
    t.text "item_30"
    t.text "item_31"
    t.text "item_32"
    t.text "item_33"
    t.text "item_34"
    t.text "item_35"
    t.text "item_36"
    t.text "item_37"
    t.text "item_38"
    t.text "item_39"
    t.text "item_40"
    t.text "item_41"
    t.text "item_42"
    t.text "item_43"
    t.text "item_44"
    t.text "item_45"
    t.text "item_46"
    t.text "item_47"
    t.text "item_48"
    t.text "item_49"
    t.text "item_50"
    t.text "item_51"
    t.text "item_52"
    t.text "item_53"
    t.text "item_54"
    t.text "item_55"
    t.text "item_56"
    t.text "item_57"
    t.text "item_58"
    t.text "item_59"
    t.text "item_60"
    t.text "item_61"
    t.text "item_62"
    t.text "item_63"
    t.text "item_64"
    t.text "item_65"
    t.text "item_66"
    t.text "item_67"
    t.text "item_68"
    t.text "item_69"
    t.text "item_70"
    t.text "item_71"
    t.text "item_72"
    t.text "item_73"
    t.text "item_74"
    t.text "item_75"
    t.text "item_76"
    t.text "item_77"
    t.text "item_78"
    t.text "item_79"
    t.text "item_80"
    t.text "item_81"
    t.text "item_82"
    t.text "item_83"
    t.text "item_84"
    t.text "item_85"
    t.text "item_86"
    t.text "item_87"
    t.text "item_88"
    t.text "item_89"
    t.text "item_90"
    t.text "item_91"
    t.text "item_92"
    t.text "item_93"
    t.text "item_94"
    t.text "item_95"
    t.text "item_96"
    t.text "item_97"
    t.text "item_98"
    t.text "item_99"
    t.text "item_100"
    t.text "item_101"
    t.text "item_102"
    t.text "item_103"
    t.text "item_104"
    t.text "item_105"
    t.text "item_106"
    t.text "item_107"
    t.text "item_108"
    t.text "item_109"
    t.text "item_110"
    t.text "item_111"
    t.text "item_112"
    t.text "item_113"
    t.text "item_114"
    t.text "item_115"
    t.text "item_116"
    t.text "item_117"
    t.text "item_118"
    t.text "item_119"
    t.text "item_120"
    t.text "item_121"
    t.text "item_122"
    t.text "item_123"
    t.text "item_124"
    t.text "item_125"
    t.text "item_126"
    t.text "item_127"
    t.text "item_128"
    t.text "item_129"
    t.text "item_130"
  end

  create_table "posttherapy_analytics", id: :text, force: :cascade do |t|
    t.datetime "creation_date", default: -> { "CURRENT_TIMESTAMP" }
    t.text "clinician_id", null: false
    t.text "client_id", null: false
    t.text "principal_diagnosis"
    t.text "secondary_diagnosis"
    t.text "attendance_schedule"
    t.float "cancellations"
    t.float "non_attendances"
    t.float "attendances"
    t.text "premature_dropout"
    t.text "therapy"
    t.text "funding"
    t.text "private_health_fund"
    t.text "referrer"
    t.text "out_of_pocket"
  end

  create_table "scale", id: :text, force: :cascade do |t|
    t.datetime "creation_date", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "update_date", default: -> { "CURRENT_TIMESTAMP" }
    t.text "clinician_id", null: false
    t.text "client_id", null: false
    t.text "measure", null: false
    t.text "subscale", null: false
    t.date "date", null: false
    t.float "score", null: false
    t.float "pts", null: false
    t.float "se", null: false
    t.float "ci", null: false
    t.float "ci_upper", null: false
    t.float "ci_lower", null: false
    t.float "mean", null: false
    t.text "mean_reference", null: false
    t.float "sd", null: false
    t.text "sd_reference", null: false
    t.float "reliability", null: false
    t.text "reliability_reference", null: false
    t.float "confidence", null: false
    t.text "method", null: false
    t.text "population", null: false
    t.text "cutoff_label_1", null: false
    t.text "cutoff_label_2", null: false
    t.text "cutoff_label_3", null: false
    t.text "cutoff_label_4", null: false
    t.text "cutoff_label_5", null: false
    t.text "cutoff_label_6", null: false
    t.float "cutoff_value_1", null: false
    t.float "cutoff_value_2", null: false
    t.float "cutoff_value_3", null: false
    t.float "cutoff_value_4", null: false
    t.float "cutoff_value_5", null: false
    t.float "cutoff_value_6", null: false
    t.text "cutoff_reference_1", null: false
    t.text "cutoff_reference_2", null: false
    t.text "cutoff_reference_3", null: false
    t.text "cutoff_reference_4", null: false
    t.text "cutoff_reference_5", null: false
    t.text "cutoff_reference_6", null: false
  end

  add_foreign_key "holding", "client", name: "holding_client_id_fkey"
  add_foreign_key "item", "client", name: "item_client_id_fkey"
  add_foreign_key "posttherapy_analytics", "client", name: "posttherapy_analytics_client_id_fkey"
  add_foreign_key "scale", "client", name: "scale_client_id_fkey"
end
