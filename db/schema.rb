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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130424180317) do

  create_table "billing_addresses", :force => true do |t|
    t.string   "street_address"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "customer_id"
  end

  add_index "billing_addresses", ["customer_id"], :name => "index_billing_addresses_on_customer_id"

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "store_id"
  end

  add_index "categories", ["store_id"], :name => "index_categories_on_store_id"

  create_table "categories_products", :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "credit_cards", :force => true do |t|
    t.string   "number"
    t.string   "security_code"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "customer_id"
  end

  add_index "credit_cards", ["customer_id"], :name => "index_credit_cards_on_customer_id"

  create_table "customers", :force => true do |t|
    t.string  "email"
    t.string  "full_name"
    t.integer "shipping_address_id"
    t.integer "billing_address_id"
    t.integer "credit_card_id"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "unit_price",    :precision => 8, :scale => 2
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.decimal  "selling_price", :precision => 8, :scale => 2
    t.decimal  "percent_off",   :precision => 8, :scale => 2
  end

  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], :name => "index_order_items_on_product_id"

  create_table "orders", :force => true do |t|
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "store_id"
    t.integer  "customer_id"
    t.string   "uuid_hash"
  end

  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"
  add_index "orders", ["store_id"], :name => "index_orders_on_store_id"

  create_table "product_categories", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "product_categories", ["category_id"], :name => "index_product_categories_on_category_id"
  add_index "product_categories", ["product_id"], :name => "index_product_categories_on_product_id"

  create_table "product_reviews", :force => true do |t|
    t.integer  "product_id"
    t.integer  "customer_id"
    t.string   "comment",     :limit => 500
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "product_reviews", ["product_id"], :name => "index_product_reviews_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",              :precision => 8, :scale => 2
    t.string   "status"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "store_id"
    t.string   "photo_url"
  end

  add_index "products", ["store_id"], :name => "index_products_on_store_id"

  create_table "questions", :force => true do |t|
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "question_id"
    t.integer  "rating"
    t.integer  "product_review_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["product_review_id"], :name => "index_ratings_on_product_review_id"
  add_index "ratings", ["question_id"], :name => "index_ratings_on_question_id"

  create_table "shipping_addresses", :force => true do |t|
    t.string   "street_address"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "customer_id"
  end

  add_index "shipping_addresses", ["customer_id"], :name => "index_shipping_addresses_on_customer_id"

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.string   "description"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "approval_status", :default => "pending"
    t.boolean  "active",          :default => false
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "store_id"
  end

  add_index "user_roles", ["user_id"], :name => "index_user_roles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "display_name"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.boolean  "platform_admin"
    t.integer  "customer_id"
  end

  add_index "users", ["customer_id"], :name => "index_users_on_customer_id"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
