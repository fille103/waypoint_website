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

ActiveRecord::Schema.define(version: 20150518002355) do

  create_table "admins", force: :cascade do |t|
    t.string   "username",        limit: 255, null: false
    t.string   "password_digest", limit: 255, null: false
    t.string   "email",           limit: 255, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "admins", ["username", "email"], name: "index_admins_on_username_and_email", using: :btree

  create_table "bios", force: :cascade do |t|
    t.text     "bio",            limit: 65535, null: false
    t.integer  "team_member_id", limit: 4,     null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "bios", ["team_member_id"], name: "index_bios_on_team_member_id", using: :btree

  create_table "contact_informations", force: :cascade do |t|
    t.string   "street_address", limit: 255, null: false
    t.string   "city",           limit: 255, null: false
    t.string   "state",          limit: 255, null: false
    t.integer  "zip",            limit: 4,   null: false
    t.integer  "phone",          limit: 4,   null: false
    t.string   "email",          limit: 255, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "contact_informations", ["state"], name: "index_contact_informations_on_state", using: :btree

  create_table "descriptions", force: :cascade do |t|
    t.text     "description", limit: 65535, null: false
    t.integer  "feature_id",  limit: 4,     null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "descriptions", ["feature_id"], name: "index_descriptions_on_feature_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "version_id", limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "features", ["version_id"], name: "index_features_on_version_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.text     "feedback",           limit: 65535, null: false
    t.integer  "registered_user_id", limit: 4,     null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "feedbacks", ["registered_user_id"], name: "index_feedbacks_on_registered_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "rating",             limit: 4, null: false
    t.integer  "registered_user_id", limit: 4
    t.integer  "version_id",         limit: 4, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ratings", ["rating"], name: "index_ratings_on_rating", using: :btree
  add_index "ratings", ["registered_user_id"], name: "fk_rails_3ca5395881", using: :btree
  add_index "ratings", ["version_id"], name: "fk_rails_e71361e52b", using: :btree

  create_table "registered_users", force: :cascade do |t|
    t.string   "username",   limit: 255, null: false
    t.string   "password",   limit: 255, null: false
    t.string   "email",      limit: 255
    t.boolean  "subscribed", limit: 1,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "registered_users", ["username", "email"], name: "index_registered_users_on_username_and_email", using: :btree

  create_table "release_notes", force: :cascade do |t|
    t.integer  "note",       limit: 4, null: false
    t.integer  "version_id", limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "release_notes", ["version_id"], name: "index_release_notes_on_version_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string   "subject",    limit: 255,   null: false
    t.text     "message",    limit: 65535, null: false
    t.integer  "rating_id",  limit: 4,     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "reviews", ["rating_id"], name: "index_reviews_on_rating_id", using: :btree

  create_table "team_members", force: :cascade do |t|
    t.string   "first_name", limit: 255, null: false
    t.string   "last_name",  limit: 255, null: false
    t.integer  "admin_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "team_members", ["admin_id"], name: "fk_rails_024510759a", using: :btree
  add_index "team_members", ["last_name"], name: "index_team_members_on_last_name", using: :btree

  create_table "versions", force: :cascade do |t|
    t.integer  "version",    limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "versions", ["version"], name: "index_versions_on_version", using: :btree

  add_foreign_key "bios", "team_members"
  add_foreign_key "descriptions", "features"
  add_foreign_key "features", "versions"
  add_foreign_key "feedbacks", "registered_users"
  add_foreign_key "ratings", "registered_users"
  add_foreign_key "ratings", "versions"
  add_foreign_key "release_notes", "versions"
  add_foreign_key "reviews", "ratings"
  add_foreign_key "team_members", "admins"
end
