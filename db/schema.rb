# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_05_17_120001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_id", null: false
    t.integer "quantity", default: 0, null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["item_id"], name: "index_cart_items_on_item_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_carts_on_member_id"
  end

  create_table "favorite_items", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_favorite_items_on_item_id"
    t.index ["member_id"], name: "index_favorite_items_on_member_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", limit: 30, default: "", null: false
    t.text "description", default: "", null: false
    t.integer "price", default: 0, null: false
    t.integer "stock", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.bigint "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["shop_id"], name: "index_items_on_shop_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", limit: 20, default: "", null: false
    t.string "first_name_kana", limit: 20, default: "", null: false
    t.string "last_name", limit: 20, default: "", null: false
    t.string "last_name_kana", limit: 20, default: "", null: false
    t.string "tel", limit: 15, default: "", null: false
    t.integer "gender", default: 1, null: false
    t.date "birthday"
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", limit: 20, default: "", null: false
    t.string "last_name", limit: 20, default: "", null: false
    t.string "first_name_kana", limit: 20, default: "", null: false
    t.string "last_name_kana", limit: 20, default: "", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "purchase_items", force: :cascade do |t|
    t.bigint "purchase_id", null: false
    t.bigint "item_id", null: false
    t.integer "quantity"
    t.integer "subtotal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_purchase_items_on_item_id"
    t.index ["purchase_id"], name: "index_purchase_items_on_purchase_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_purchases_on_member_id"
  end

  create_table "release_infos", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "status"
    t.bigint "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_release_infos_on_shop_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "item_id", null: false
    t.string "title"
    t.text "comment"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_reviews_on_item_id"
    t.index ["member_id"], name: "index_reviews_on_member_id"
  end

  create_table "shipping_infos", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "postal_code", default: "", null: false
    t.string "country", default: "", null: false
    t.string "prefecture", default: "", null: false
    t.string "city", default: "", null: false
    t.string "address", default: "", null: false
    t.string "building", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_shipping_infos_on_member_id"
  end

  create_table "shop_categories", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shop_category_assignments", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.bigint "shop_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_category_id"], name: "index_shop_category_assignments_on_shop_category_id"
    t.index ["shop_id", "shop_category_id"], name: "idx_on_shop_id_shop_category_id_d39c66ffd7", unique: true
    t.index ["shop_id"], name: "index_shop_category_assignments_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name", limit: 30, default: "", null: false
    t.text "description", default: "", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["owner_id"], name: "index_shops_on_owner_id"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "items"
  add_foreign_key "carts", "members"
  add_foreign_key "favorite_items", "items"
  add_foreign_key "favorite_items", "members"
  add_foreign_key "items", "shops"
  add_foreign_key "purchase_items", "items"
  add_foreign_key "purchase_items", "purchases"
  add_foreign_key "purchases", "members"
  add_foreign_key "release_infos", "shops"
  add_foreign_key "reviews", "items"
  add_foreign_key "reviews", "members"
  add_foreign_key "shop_category_assignments", "shop_categories"
  add_foreign_key "shop_category_assignments", "shops"
  add_foreign_key "shops", "owners"
end
