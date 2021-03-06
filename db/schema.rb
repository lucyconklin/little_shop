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

ActiveRecord::Schema.define(version: 20170111210717) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
    t.index ["slug"], name: "index_categories_on_slug", unique: true, using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "stripe_id"
    t.string   "stripe_checkout_id"
    t.string   "card_brand"
    t.string   "card_last4"
    t.string   "card_exp_month"
    t.string   "card_exp_year"
    t.index ["email"], name: "index_customers_on_email", unique: true, using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "price_in_cents"
    t.integer  "category_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "image_url"
    t.boolean  "retired",        default: false
    t.index ["category_id"], name: "index_items_on_category_id", using: :btree
    t.index ["title"], name: "index_items_on_title", unique: true, using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "item_price_in_cents"
    t.integer  "item_quantity"
    t.integer  "item_id"
    t.integer  "order_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["item_id"], name: "index_order_items_on_item_id", using: :btree
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "total_price_in_cents"
    t.integer  "status_id"
    t.integer  "customer_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id", using: :btree
    t.index ["status_id"], name: "index_orders_on_status_id", using: :btree
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "statuses"
end
