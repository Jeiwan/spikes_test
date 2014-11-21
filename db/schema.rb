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

ActiveRecord::Schema.define(version: 20141121184819) do

  create_table "admin_invoice_positions", force: true do |t|
    t.integer  "article_id"
    t.integer  "invoice_id"
    t.integer  "quantity"
    t.float    "price",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_invoice_positions", ["article_id"], name: "index_admin_invoice_positions_on_article_id", using: :btree
  add_index "admin_invoice_positions", ["invoice_id"], name: "index_admin_invoice_positions_on_invoice_id", using: :btree

  create_table "admin_invoices", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_stacks", force: true do |t|
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_stacks", ["product_id"], name: "index_product_stacks_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.float    "price",            limit: 24
    t.integer  "product_stack_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["product_stack_id"], name: "index_products_on_product_stack_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",               default: "",    null: false
    t.boolean  "admin",                  default: false, null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
