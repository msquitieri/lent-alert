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

ActiveRecord::Schema.define(version: 20150303043832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "emails", force: :cascade do |t|
    t.string   "subject"
    t.string   "headline"
    t.string   "body"
    t.string   "special"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "source"
    t.integer  "height"
    t.integer  "width"
    t.integer  "email_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "images", ["email_id"], name: "index_images_on_email_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "time_zone"
    t.string   "phone_number"
    t.integer  "alert_hour"
    t.integer  "alert_minute"
  end

  add_index "users", ["alert_hour", "alert_minute"], name: "index_users_on_alert_hour_and_alert_minute", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "images", "emails"
end
