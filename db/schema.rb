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

ActiveRecord::Schema.define(version: 20150506183953) do

  create_table "admins", force: :cascade do |t|
    t.string   "username",   limit: 255, null: false
    t.string   "password",   limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "bios", force: :cascade do |t|
    t.string   "biography",      limit: 255, null: false
    t.integer  "team_member_id", limit: 4,   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "bios", ["team_member_id"], name: "fk_rails_87772f8338", using: :btree

  create_table "contact_information", force: :cascade do |t|
    t.string   "street_address", limit: 255, null: false
    t.string   "city",           limit: 255, null: false
    t.string   "state",          limit: 255, null: false
    t.integer  "zip",            limit: 4,   null: false
    t.integer  "phone",          limit: 4,   null: false
    t.string   "email",          limit: 255, null: false
    t.integer  "admin_id",       limit: 4,   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "contact_information", ["admin_id"], name: "fk_rails_11d2fb4deb", using: :btree

  create_table "feature_descriptions", force: :cascade do |t|
    t.text     "description",         limit: 65535, null: false
    t.integer  "waypoint_feature_id", limit: 4,     null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "feature_descriptions", ["waypoint_feature_id"], name: "fk_rails_f7325b34b9", using: :btree

  create_table "feedback", force: :cascade do |t|
    t.text     "feedback",           limit: 65535, null: false
    t.integer  "registered_user_id", limit: 4,     null: false
    t.integer  "admin_id",           limit: 4,     null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "feedback", ["admin_id"], name: "fk_rails_ea7a8fb614", using: :btree
  add_index "feedback", ["registered_user_id"], name: "fk_rails_f29a470ead", using: :btree

  create_table "registered_users", force: :cascade do |t|
    t.string   "username",   limit: 255, null: false
    t.string   "password",   limit: 255, null: false
    t.string   "email",      limit: 255
    t.boolean  "subscribed", limit: 1,   null: false
    t.integer  "admin_id",   limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "registered_users", ["admin_id"], name: "fk_rails_fe39daf870", using: :btree
  add_index "registered_users", ["username", "email"], name: "index_registered_users_on_username_and_email", using: :btree

  create_table "team_members", force: :cascade do |t|
    t.string   "first_name", limit: 255, null: false
    t.string   "last_name",  limit: 255, null: false
    t.integer  "admin_id",   limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "team_members", ["admin_id"], name: "fk_rails_024510759a", using: :btree

  create_table "waypoint_features", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "admin_id",   limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "waypoint_features", ["admin_id"], name: "fk_rails_c9fa7ee517", using: :btree
  add_index "waypoint_features", ["name"], name: "index_waypoint_features_on_name", using: :btree

  add_foreign_key "bios", "team_members"
  add_foreign_key "contact_information", "admins"
  add_foreign_key "feature_descriptions", "waypoint_features"
  add_foreign_key "feedback", "admins"
  add_foreign_key "feedback", "registered_users"
  add_foreign_key "registered_users", "admins"
  add_foreign_key "team_members", "admins"
  add_foreign_key "waypoint_features", "admins"
end
