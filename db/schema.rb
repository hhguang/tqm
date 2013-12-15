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

ActiveRecord::Schema.define(version: 20131215031237) do

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exams", force: true do |t|
    t.string   "name"
    t.boolean  "closed"
    t.text     "brief"
    t.integer  "user_id"
    t.integer  "qx_id"
    t.integer  "exam_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "upload_started", default: false
    t.text     "report_demand"
  end

  create_table "identities", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", force: true do |t|
    t.integer  "paper_order_id"
    t.integer  "school_id"
    t.string   "school_name"
    t.integer  "g1yw",           default: 0
    t.integer  "g1sx",           default: 0
    t.integer  "g1yy",           default: 0
    t.integer  "g1wl",           default: 0
    t.integer  "g1hx",           default: 0
    t.integer  "g1sw",           default: 0
    t.integer  "g1zz",           default: 0
    t.integer  "g1ls",           default: 0
    t.integer  "g1dl",           default: 0
    t.integer  "g2w",            default: 0
    t.integer  "g2l",            default: 0
    t.integer  "g2yw",           default: 0
    t.integer  "g2sxl",          default: 0
    t.integer  "g2sxw",          default: 0
    t.integer  "g2yy",           default: 0
    t.integer  "g2wl",           default: 0
    t.integer  "g2hx",           default: 0
    t.integer  "g2sw",           default: 0
    t.integer  "g2zz",           default: 0
    t.integer  "g2ls",           default: 0
    t.integer  "g2dl",           default: 0
    t.integer  "g3w",            default: 0
    t.integer  "g3l",            default: 0
    t.integer  "g3yw",           default: 0
    t.integer  "g3sxl",          default: 0
    t.integer  "g3sxw",          default: 0
    t.integer  "g3yy",           default: 0
    t.integer  "g3wz",           default: 0
    t.integer  "g3lz",           default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed",      default: false
    t.string   "handler"
    t.string   "telephone"
  end

  create_table "paper_orders", force: true do |t|
    t.string   "name"
    t.integer  "item_type"
    t.boolean  "state"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: true do |t|
    t.string   "action"
    t.string   "subject_class"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qxes", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.string   "title"
    t.integer  "exam_id"
    t.integer  "school_id"
    t.integer  "user_id"
    t.string   "file"
    t.string   "file_name"
    t.string   "subject_name"
    t.string   "group_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "qx_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "score_files", force: true do |t|
    t.string   "filename"
    t.string   "disk_filename"
    t.integer  "filesize"
    t.string   "content_type"
    t.integer  "digest"
    t.integer  "user_id"
    t.integer  "school_id"
    t.integer  "exam_id"
    t.boolean  "confirmed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "f_type"
    t.string   "file"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                     limit: 40
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.string   "remember_token",            limit: 40
    t.datetime "remember_token_expires_at"
    t.integer  "school_id"
    t.boolean  "is_admin",                             default: false
    t.integer  "qx_id"
    t.string   "telephone"
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true

  create_table "users_roles_relations", force: true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
