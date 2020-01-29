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

ActiveRecord::Schema.define(version: 2020_01_29_170136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "followers", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "follower_id", null: false
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "sleeping_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "check_in_time", null: false
    t.datetime "check_out_time"
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "date", "check_in_time"], name: "index_sleeping_records_on_user_id_and_date_and_check_in_time", unique: true
    t.index ["user_id"], name: "index_sleeping_records_on_user_id"
  end

  create_table "team_member_team_leads", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_member_id"
    t.index ["team_member_id"], name: "index_team_member_team_leads_on_team_member_id"
    t.index ["user_id", "team_member_id"], name: "lead_member_index", unique: true
    t.index ["user_id"], name: "index_team_member_team_leads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_users_on_name"
  end

  add_foreign_key "sleeping_records", "users"
end
