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

ActiveRecord::Schema.define(version: 20130927001655) do

  create_table "chat_participations", force: true do |t|
    t.integer  "chat_id",     null: false
    t.integer  "user_id",     null: false
    t.datetime "read_at"
    t.datetime "archived_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chat_participations", ["chat_id"], name: "index_chat_participations_on_chat_id", using: :btree
  add_index "chat_participations", ["user_id"], name: "index_chat_participations_on_user_id", using: :btree

  create_table "chats", force: true do |t|
    t.string   "subject"
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chats", ["user_id"], name: "index_chats_on_user_id", using: :btree

  create_table "group_memberships", force: true do |t|
    t.integer  "user_id",                    null: false
    t.integer  "group_id",                   null: false
    t.boolean  "is_owner",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id", using: :btree
  add_index "group_memberships", ["user_id"], name: "index_group_memberships_on_user_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "title",        null: false
    t.integer  "member_count"
    t.text     "owner_ids"
    t.string   "subject"
    t.string   "sub_subject"
    t.integer  "start_level"
    t.integer  "end_level"
    t.integer  "edmodo_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["edmodo_id"], name: "index_groups_on_edmodo_id", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.integer  "chat_id",    null: false
    t.integer  "user_id",    null: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["chat_id"], name: "index_messages_on_chat_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "user_type",      null: false
    t.string   "edmodo_id",      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "avatar_url"
    t.string   "thumb_url"
    t.string   "locale"
    t.string   "time_zone"
    t.integer  "school_id"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "edmodo_user_id"
  end

  add_index "users", ["edmodo_id"], name: "index_users_on_edmodo_id", unique: true, using: :btree
  add_index "users", ["user_type"], name: "index_users_on_user_type", using: :btree

end
