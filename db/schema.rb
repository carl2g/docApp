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

ActiveRecord::Schema.define(version: 2019_02_06_124646) do

  create_table "diabetes", force: :cascade do |t|
    t.integer "modules_id"
    t.float "glucose"
    t.integer "carbs"
    t.string "meal_type"
    t.string "meal_description"
    t.float "insulin_food"
    t.float "insulin_corr"
    t.string "activity_type"
    t.string "activity_description"
    t.string "notes"
    t.float "a1c"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modules_id"], name: "index_diabetes_on_modules_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.integer "user_id"
  end

  create_table "modules", force: :cascade do |t|
    t.string "name"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_modules_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.integer "user_id"
    t.integer "doctors_id"
    t.index ["doctors_id"], name: "index_patients_on_doctors_id"
  end

  create_table "user_status", force: :cascade do |t|
    t.integer "status", default: 0
    t.index [nil], name: "index_user_status_on_user_id"
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
