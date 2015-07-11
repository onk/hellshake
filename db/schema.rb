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

ActiveRecord::Schema.define(version: 20150708183859) do

  create_table "presentation_outlines", force: :cascade do |t|
    t.integer  "presentation_id", limit: 4,        null: false
    t.text     "body",            limit: 16777215
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "presentation_outlines", ["presentation_id"], name: "presentation_id", unique: true, using: :btree

  create_table "presentations", force: :cascade do |t|
    t.integer  "user_id",       limit: 4,                   null: false
    t.string   "title",         limit: 255,                 null: false
    t.boolean  "is_public",     limit: 1,   default: false, null: false
    t.string   "original_file", limit: 255
    t.string   "pdf_file",      limit: 255
    t.string   "image_file",    limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "presentations", ["user_id", "is_public"], name: "user_id_and_is_public", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "name", unique: true, using: :btree

  create_table "user_accounts", force: :cascade do |t|
    t.integer  "user_id",          limit: 4,   null: false
    t.string   "provider",         limit: 255, null: false
    t.string   "uid",              limit: 255, null: false
    t.string   "token",            limit: 511, null: false
    t.string   "token_secret",     limit: 255
    t.datetime "token_expires_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "user_accounts", ["provider", "uid"], name: "provider_and_uid", unique: true, using: :btree
  add_index "user_accounts", ["user_id", "provider"], name: "user_id_and_provider", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "username",            limit: 255, null: false
    t.datetime "remember_created_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["username"], name: "username", unique: true, using: :btree

end
