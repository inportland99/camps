# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140818145804) do

  create_table "camp_offerings", force: true do |t|
    t.integer  "camp_id"
    t.string   "teacher"
    t.string   "assistant"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "location_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "offering_time"
    t.integer  "classroom"
    t.integer  "week"
    t.string   "time"
    t.boolean  "hidden"
  end

  create_table "camp_offerings_registrations", id: false, force: true do |t|
    t.integer "camp_offering_id", null: false
    t.integer "registration_id",  null: false
  end

  add_index "camp_offerings_registrations", ["camp_offering_id", "registration_id"], name: "camp_off_reg", unique: true

  create_table "camp_surveys", force: true do |t|
    t.text     "comment"
    t.text     "improvements"
    t.string   "parent_first_name"
    t.string   "parent_last_name"
    t.string   "student_name"
    t.string   "grade_completed"
    t.string   "phone"
    t.string   "email"
    t.time     "contact_time"
    t.string   "preferred_contact"
    t.boolean  "contact_fall"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "satisfaction"
    t.integer  "camp_id"
    t.integer  "location_id"
    t.boolean  "contacted",         default: false
  end

  create_table "camp_surveys_weekly_programs", id: false, force: true do |t|
    t.integer "camp_survey_id",    null: false
    t.integer "weekly_program_id", null: false
  end

  add_index "camp_surveys_weekly_programs", ["camp_survey_id", "weekly_program_id"], name: "samp_survery_prog"

  create_table "camps", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "capacity"
    t.string   "age"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "price"
  end

  create_table "coupon_codes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "amount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "coupon_type"
    t.boolean  "active"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "telephone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: true do |t|
    t.string   "parent_first_name"
    t.string   "parent_last_name"
    t.string   "parent_address_1"
    t.string   "parent_address_2"
    t.string   "parent_email"
    t.string   "parent_phone"
    t.string   "student_first_name"
    t.string   "student_last_name"
    t.string   "student_grade"
    t.string   "student_allergies"
    t.string   "emergency_contact_name"
    t.string   "emergency_contact_phone"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "stripe_customer_token"
    t.string   "stripe_charge_token"
    t.integer  "total"
    t.string   "parent_city"
    t.string   "parent_state"
    t.integer  "parent_zip"
    t.integer  "location_id"
    t.string   "coupon_code"
    t.boolean  "camp_campaign",           default: false
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "location_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weekly_programs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
