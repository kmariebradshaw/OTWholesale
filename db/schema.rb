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

ActiveRecord::Schema.define(version: 2024_04_03_213556) do

  create_table "customers", force: :cascade do |t|
    t.string "company", null: false
    t.string "dba"
    t.string "permit", null: false
    t.string "seller_permit_state", null: false
    t.integer "locations"
    t.string "legal_status", null: false
    t.string "billing_addr", null: false
    t.string "billing_city", null: false
    t.string "billing_state", null: false
    t.string "billing_zip", null: false
    t.string "billing_ap", null: false
    t.string "billing_phone"
    t.string "billing_email", null: false
    t.string "shipping_location"
    t.string "shipping_address"
    t.string "shipping_state"
    t.string "shipping_zip"
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.string "top3_1"
    t.string "top3_2"
    t.string "top3_3"
    t.string "facebook"
    t.string "instagram"
    t.boolean "agree1", null: false
    t.boolean "agree2", null: false
    t.boolean "signed"
    t.string "referral_source"
    t.string "referral_source_other"
    t.string "status", default: "pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "attachement"
    t.integer "employee_id"
    t.string "issues"
    t.boolean "agree3"
    t.string "note"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved", default: false, null: false
    t.boolean "admin"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
