# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2025_05_06_155512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "camp_interests", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "year"
    t.boolean "newsletter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "camp_offerings", force: :cascade do |t|
    t.integer "camp_id"
    t.string "teacher"
    t.string "assistant"
    t.date "start_date"
    t.date "end_date"
    t.integer "location_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "offering_time"
    t.integer "classroom"
    t.integer "week"
    t.string "time"
    t.boolean "hidden"
    t.integer "year"
    t.boolean "extended_care", default: false
    t.string "zoom_link"
  end

  create_table "camp_offerings_registrations", id: false, force: :cascade do |t|
    t.bigint "camp_offering_id", null: false
    t.bigint "registration_id", null: false
    t.index ["camp_offering_id", "registration_id"], name: "camp_off_reg", unique: true
    t.index ["camp_offering_id"], name: "index_camp_offerings_registrations_on_camp_offering_id"
    t.index ["registration_id"], name: "index_camp_offerings_registrations_on_registration_id"
  end

  create_table "camp_surveys", force: :cascade do |t|
    t.text "comment"
    t.text "improvements"
    t.string "parent_first_name"
    t.string "parent_last_name"
    t.string "student_name"
    t.string "grade_completed"
    t.string "phone"
    t.string "email"
    t.time "contact_time"
    t.string "preferred_contact"
    t.boolean "contact_fall"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "satisfaction"
    t.integer "camp_id"
    t.integer "location_id"
    t.boolean "contacted", default: false
  end

  create_table "camp_surveys_weekly_programs", id: false, force: :cascade do |t|
    t.bigint "camp_survey_id", null: false
    t.bigint "weekly_program_id", null: false
    t.index ["camp_survey_id", "weekly_program_id"], name: "samp_survery_prog"
    t.index ["camp_survey_id"], name: "index_camp_surveys_weekly_programs_on_camp_survey_id"
    t.index ["weekly_program_id"], name: "index_camp_surveys_weekly_programs_on_weekly_program_id"
  end

  create_table "camps", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "capacity"
    t.string "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price"
    t.text "show_description"
    t.boolean "girls_only", default: false
    t.text "video_url"
    t.boolean "online"
    t.boolean "active", default: false
    t.string "parent_webpage"
  end

  create_table "coupon_codes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "coupon_type"
    t.boolean "active"
    t.string "image_uid", default: ""
    t.integer "half_day_discount", default: 0
    t.integer "full_day_discount", default: 0
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "registration_id"
    t.boolean "paid", default: false
    t.date "payment_date"
    t.string "stripe_charge_id"
    t.string "stripe_customer_id"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "attempts", default: 0
    t.boolean "payment_declined", default: false
    t.date "due_date"
    t.integer "payment_order"
    t.string "charge_description"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "telephone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "directions"
  end

  create_table "registrations", force: :cascade do |t|
    t.string "parent_first_name"
    t.string "parent_last_name"
    t.string "parent_address_1"
    t.string "parent_address_2"
    t.string "parent_email"
    t.string "parent_phone"
    t.string "student_first_name"
    t.string "student_last_name"
    t.string "student_grade"
    t.string "student_allergies"
    t.string "emergency_contact_name"
    t.string "emergency_contact_phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_customer_token"
    t.string "stripe_charge_token"
    t.integer "total"
    t.string "parent_city"
    t.string "parent_state"
    t.integer "parent_zip"
    t.integer "location_id"
    t.string "coupon_code"
    t.boolean "camp_campaign", default: false
    t.integer "year"
    t.boolean "newsletter", default: false
    t.string "coupon_uid", default: ""
    t.boolean "payment_plan", default: false
    t.string "stripe_customer_id"
    t.boolean "payment_plan_completed", default: false
    t.string "referred_by"
    t.integer "infusionsoft_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "location_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weekly_programs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
