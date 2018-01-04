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

ActiveRecord::Schema.define(version: 20180104090428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.bigint "user_id"
    t.string "uniq_id"
    t.string "contact_person_name"
    t.string "contact_person_email"
    t.string "contact_person_phone"
    t.string "company_name"
    t.text "company_address"
    t.string "company_postcode"
    t.string "company_city"
    t.string "company_state"
    t.string "company_country"
    t.string "company_email"
    t.string "company_phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uniq_id"], name: "index_clients_on_uniq_id", unique: true
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "company_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "company_name"
    t.string "contact_number"
    t.text "address"
    t.string "postcode"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reg_num"
    t.index ["reg_num"], name: "index_company_profiles_on_reg_num", unique: true
    t.index ["user_id"], name: "index_company_profiles_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.text "description"
    t.string "itemable_type"
    t.bigint "itemable_id"
    t.integer "quantity", default: 0
    t.decimal "price", precision: 8, scale: 2
    t.decimal "total_price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["itemable_type", "itemable_id"], name: "index_items_on_itemable_type_and_itemable_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "default_picture"
    t.string "first_name"
    t.string "last_name"
    t.text "address"
    t.string "postcode"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "client_id"
    t.string "ref_number"
    t.datetime "valid_until"
    t.integer "status", default: 0
    t.decimal "sub_total", precision: 8, scale: 2
    t.decimal "tax_rate", precision: 4, scale: 3
    t.decimal "tax", precision: 8, scale: 2
    t.decimal "total", precision: 8, scale: 2
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sender_id"
    t.index ["client_id"], name: "index_quotations_on_client_id"
    t.index ["ref_number"], name: "index_quotations_on_ref_number", unique: true
    t.index ["sender_id"], name: "index_quotations_on_sender_id"
    t.index ["user_id"], name: "index_quotations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enterprise", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "clients", "users"
  add_foreign_key "company_profiles", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "quotations", "clients"
  add_foreign_key "quotations", "company_profiles", column: "sender_id"
  add_foreign_key "quotations", "users"
end
