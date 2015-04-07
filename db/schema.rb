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

ActiveRecord::Schema.define(version: 20150406160520) do

  create_table "businesses", force: :cascade do |t|
    t.string   "yid"
    t.string   "name"
    t.string   "neighborhoods"
    t.string   "full_address"
    t.string   "city"
    t.string   "state"
    t.float    "stars"
    t.integer  "review_count"
    t.string   "categories"
    t.boolean  "open"
    t.string   "hours"
    t.string   "yattributes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "business_id"
    t.string   "user_id"
    t.float    "stars"
    t.text     "description"
    t.string   "date"
    t.string   "votes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tips", force: :cascade do |t|
    t.text     "description"
    t.string   "business_id"
    t.string   "user_id"
    t.string   "date"
    t.integer  "likes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "yid"
    t.string   "name"
    t.integer  "review_count"
    t.float    "average_stars"
    t.integer  "votes"
    t.string   "friends"
    t.string   "compliments"
    t.integer  "fans"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
