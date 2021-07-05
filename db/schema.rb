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

ActiveRecord::Schema.define(version: 2021_07_03_143612) do

  create_table "customers", force: :cascade do |t|
    t.string "company"
    t.string "dba"
    t.string "permit"
    t.string "seller_permit_state"
    t.integer "locations"
    t.string "legal_status"
    t.string "billing_addr"
    t.string "billing_city"
    t.string "billing_state"
    t.string "billing_zip"
    t.string "billing_ap"
    t.string "billing_phone"
    t.string "billing_email"
    t.string "shipping_location"
    t.string "shipping_address"
    t.string "shipping_state"
    t.string "shipping_zip"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "top3_1"
    t.string "top3_2"
    t.string "top3_3"
    t.string "facebook"
    t.string "instagram"
    t.boolean "agree1"
    t.boolean "agree2"
    t.boolean "signed"
    t.string "referral_source"
    t.string "referral_source_other"
    t.string "status", default: "pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
