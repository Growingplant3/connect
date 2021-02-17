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

ActiveRecord::Schema.define(version: 2021_02_16_113733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "pharmacy_id"
    t.integer "day_of_the_week"
    t.boolean "business", default: false
    t.datetime "opening_time"
    t.datetime "closing_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pharmacy_id"], name: "index_activities_on_pharmacy_id"
  end

  create_table "information_disclosures", force: :cascade do |t|
    t.integer "user_id"
    t.integer "pharmacy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "pharmacy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medicine_notebook_records", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "pharmacy_id"
    t.date "date_of_issue", null: false
    t.date "date_of_dispensing", null: false
    t.string "medical_institution_name", null: false
    t.string "doctor_name", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pharmacy_id"], name: "index_medicine_notebook_records_on_pharmacy_id"
    t.index ["user_id"], name: "index_medicine_notebook_records_on_user_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.string "name", null: false
    t.float "standard", null: false
    t.integer "unit", null: false
    t.boolean "permission", default: false, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_medicines_on_user_id"
  end

  create_table "pharmacies", force: :cascade do |t|
    t.string "name", null: false
    t.string "postcode"
    t.string "address"
    t.string "normal_telephone_number"
    t.string "emergency_telephone_number"
    t.text "note"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_pharmacies_on_email", unique: true
    t.index ["emergency_telephone_number"], name: "index_pharmacies_on_emergency_telephone_number"
    t.index ["name"], name: "index_pharmacies_on_name"
    t.index ["normal_telephone_number"], name: "index_pharmacies_on_normal_telephone_number"
    t.index ["reset_password_token"], name: "index_pharmacies_on_reset_password_token", unique: true
  end

  create_table "prescription_details", force: :cascade do |t|
    t.bigint "medicine_notebook_record_id"
    t.integer "prescription_days", null: false
    t.integer "times", null: false
    t.float "daily_dose", null: false
    t.string "number_of_dose", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medicine_notebook_record_id"], name: "index_prescription_details_on_medicine_notebook_record_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "postcode"
    t.string "address"
    t.string "telephone_number"
    t.date "birthday"
    t.integer "sex", default: 0
    t.text "side_effect"
    t.text "allergy"
    t.text "sick"
    t.text "operation"
    t.text "note"
    t.integer "role", default: 0
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["birthday"], name: "index_users_on_birthday"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["sex"], name: "index_users_on_sex"
    t.index ["telephone_number"], name: "index_users_on_telephone_number"
  end

  add_foreign_key "activities", "pharmacies"
  add_foreign_key "medicine_notebook_records", "pharmacies"
  add_foreign_key "medicine_notebook_records", "users"
  add_foreign_key "medicines", "users"
  add_foreign_key "prescription_details", "medicine_notebook_records"
end
