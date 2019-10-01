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

ActiveRecord::Schema.define(version: 2019_09_22_101703) do

  create_table "doctor_unit_notes", force: :cascade do |t|
    t.integer "note_id"
    t.integer "doctor_unit_id"
    t.json "filter"
    t.json "string"
    t.index ["doctor_unit_id"], name: "index_doctor_unit_notes_on_doctor_unit_id"
    t.index ["note_id"], name: "index_doctor_unit_notes_on_note_id"
  end

  create_table "doctor_units", force: :cascade do |t|
    t.integer "doctor_id"
    t.integer "unit_id"
    t.index ["doctor_id"], name: "index_doctor_units_on_doctor_id"
    t.index ["unit_id"], name: "index_doctor_units_on_unit_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.integer "user_id"
  end

  create_table "general_unit_doctors", force: :cascade do |t|
    t.integer "doctor_id"
    t.integer "general_unit_id"
    t.index ["doctor_id"], name: "index_general_unit_doctors_on_doctor_id"
    t.index ["general_unit_id"], name: "index_general_unit_doctors_on_general_unit_id"
  end

  create_table "general_units", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.string "color"
    t.json "filter", default: {}
  end

  create_table "notes", force: :cascade do |t|
    t.integer "unit_id"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_notes_on_unit_id"
  end

  create_table "patients", force: :cascade do |t|
    t.integer "user_id"
  end

  create_table "units", force: :cascade do |t|
    t.integer "patient_id"
    t.integer "general_unit_id"
    t.json "filter", default: "\"{}\""
    t.index ["general_unit_id"], name: "index_units_on_general_unit_id"
    t.index ["patient_id"], name: "index_units_on_patient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "password"
    t.string "login_token"
    t.time "last_connection"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
