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

ActiveRecord::Schema.define(version: 20140602030041) do

  create_table "dine_outs", force: true do |t|
    t.integer  "restaurants_id"
    t.string   "name"
    t.string   "kind"
    t.string   "phone_num"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "meal"
  end

  create_table "food_items", force: true do |t|
    t.string   "name"
    t.float    "price"
    t.string   "description"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "restaurants_id"
  end

  create_table "meals", force: true do |t|
    t.string   "entree"
    t.float    "price"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: true do |t|
    t.integer  "restaurants_id"
    t.string   "name"
    t.integer  "party_size"
    t.datetime "timeStart"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "owner"
    t.string   "phone"
    t.string   "address"
    t.time     "sundayOpen"
    t.time     "sundayClose"
    t.time     "mondayOpen"
    t.time     "mondayClose"
    t.time     "tuesdayOpen"
    t.time     "tuesdayClose"
    t.time     "wednesdayOpen"
    t.time     "wednesdayClose"
    t.time     "thursdayOpen"
    t.time     "thursdayClose"
    t.time     "fridayOpen"
    t.time     "fridayClose"
    t.time     "saturdayOpen"
    t.time     "saturdayClose"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "email"
  end

  add_index "restaurants", ["remember_token"], name: "index_restaurants_on_remember_token"

end
