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

ActiveRecord::Schema.define(version: 20140530010634) do

  create_table "dine_outs", force: true do |t|
    t.integer  "restaurants_id"
    t.string   "name"
    t.string   "type"
    t.string   "phone_num"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "food_items", force: true do |t|
    t.string   "name"
    t.float    "price"
    t.string   "description"
    t.integer
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: true do |t|
    t.integer  "restaurants_id"
    t.string   "name"
    t.integer  "party_size"
    t.datetime "timeStart" #you android bastards, this is killing me
    t.integer  "waiter_id" 
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "owner"
    t.string   "phone"
    t.string   "address"
    t.integer  "sunday"
    t.integer  "monday"
    t.ingeger  "tuesday"
    t.ingeger  "wednesday"
    t.ingeger  "thursday"
    t.ingeger  "friday"
    t.ingeger  "saturday"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "restaurants", ["remember_token"], name: "index_restaurants_on_remember_token"

end

