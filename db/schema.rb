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

ActiveRecord::Schema.define(version: 20161124024840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invitations", force: :cascade do |t|
    t.string   "email"
    t.integer  "publisher_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["email"], name: "index_invitations_on_email", using: :btree
    t.index ["publisher_id"], name: "index_invitations_on_publisher_id", using: :btree
  end

  create_table "proposals", force: :cascade do |t|
    t.text     "summary"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "site_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "active"
    t.boolean  "first_to_market"
    t.datetime "expiration"
    t.boolean  "sponsored"
    t.bigint   "est_reach"
    t.integer  "min_price"
    t.integer  "max_price"
    t.datetime "flight_date"
    t.string   "support_doc"
    t.index ["site_id"], name: "index_proposals_on_site_id", using: :btree
    t.index ["user_id", "created_at"], name: "index_proposals_on_user_id_and_created_at", using: :btree
    t.index ["user_id"], name: "index_proposals_on_user_id", using: :btree
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["name"], name: "index_publishers_on_name", unique: true, using: :btree
  end

  create_table "sites", force: :cascade do |t|
    t.integer  "publisher_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["publisher_id"], name: "index_sites_on_publisher_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "publisher_id"
    t.boolean  "lead",              default: false
    t.string   "picture"
    t.string   "time_zone",         default: "UTC"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["publisher_id"], name: "index_users_on_publisher_id", using: :btree
  end

  add_foreign_key "invitations", "publishers"
  add_foreign_key "proposals", "sites"
  add_foreign_key "proposals", "users"
  add_foreign_key "sites", "publishers"
end
