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

ActiveRecord::Schema.define(:version => 20120723092500) do

  create_table "addresses", :force => true do |t|
    t.integer  "user_id"
    t.string   "zip"
    t.string   "city"
    t.string   "additional"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "billing",    :default => false, :null => false
    t.text     "name"
    t.boolean  "default"
  end

  create_table "advantage_translations", :force => true do |t|
    t.integer  "advantage_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "advantage_translations", ["advantage_id"], :name => "index_advantage_translations_on_advantage_id"
  add_index "advantage_translations", ["locale"], :name => "index_advantage_translations_on_locale"

  create_table "advantages", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advantages_to_products", :force => true do |t|
    t.integer  "product_id",   :null => false
    t.integer  "advantage_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file"
    t.string   "small_image_file"
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "discount_id"
    t.string   "slug"
    t.integer  "position"
    t.string   "image_file"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug"

  create_table "categories_custom_category_groups", :force => true do |t|
    t.integer  "category_id"
    t.integer  "custom_category_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories_custom_category_groups", ["category_id", "custom_category_group_id"], :name => "relation", :unique => true

  create_table "category_translations", :force => true do |t|
    t.integer  "category_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_translations", ["category_id"], :name => "index_category_translations_on_category_id"
  add_index "category_translations", ["locale"], :name => "index_category_translations_on_locale"

  create_table "content_translations", :force => true do |t|
    t.integer  "content_id"
    t.string   "locale"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_translations", ["content_id"], :name => "index_content_translations_on_content_id"
  add_index "content_translations", ["locale"], :name => "index_content_translations_on_locale"

  create_table "contents", :force => true do |t|
    t.string   "name"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "contents", ["slug"], :name => "index_contents_on_slug"

  create_table "coupons", :force => true do |t|
    t.string   "code"
    t.boolean  "used",        :default => false, :null => false
    t.integer  "offer_value"
    t.integer  "offer_type"
    t.date     "valid_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  create_table "custom_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",              :null => false
    t.integer  "discount_id"
    t.string   "slug"
    t.integer  "custom_category_group_id"
    t.string   "image_file"
  end

  add_index "custom_categories", ["category_id"], :name => "category_id"
  add_index "custom_categories", ["custom_category_group_id"], :name => "custom_category_group_id"
  add_index "custom_categories", ["slug"], :name => "index_custom_categories_on_slug"

  create_table "custom_category_group_translations", :force => true do |t|
    t.integer  "custom_category_group_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_category_group_translations", ["custom_category_group_id"], :name => "index_2d2af31d0c65d872f84f034613e30745ce4dbf44"
  add_index "custom_category_group_translations", ["locale"], :name => "index_custom_category_group_translations_on_locale"

  create_table "custom_category_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_category_translations", :force => true do |t|
    t.integer  "custom_category_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_category_translations", ["custom_category_id"], :name => "index_2ed22b0e6ab5c4c96ef06c49b081590ff17c3b7e"
  add_index "custom_category_translations", ["locale"], :name => "index_custom_category_translations_on_locale"

  create_table "designer_photos", :force => true do |t|
    t.integer  "designer_id"
    t.string   "image_file"
    t.string   "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designer_translations", :force => true do |t|
    t.integer  "designer_id"
    t.string   "locale"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "designer_translations", ["designer_id"], :name => "index_designer_translations_on_designer_id"
  add_index "designer_translations", ["locale"], :name => "index_designer_translations_on_locale"

  create_table "designers", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brand_id"
  end

  create_table "discounts", :force => true do |t|
    t.integer  "discount_type", :null => false
    t.integer  "value",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discounts_to_products", :force => true do |t|
    t.integer  "product_id",  :null => false
    t.integer  "discount_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discounts_to_products", ["product_id", "discount_id"], :name => "relation", :unique => true

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   :default => 1
  end

  create_table "links", :force => true do |t|
    t.string   "link_text"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links_products", :force => true do |t|
    t.integer  "link_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturer_photos", :force => true do |t|
    t.integer  "manufacturer_id"
    t.string   "image_file"
    t.string   "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturer_translations", :force => true do |t|
    t.integer  "manufacturer_id"
    t.string   "locale"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manufacturer_translations", ["locale"], :name => "index_manufacturer_translations_on_locale"
  add_index "manufacturer_translations", ["manufacturer_id"], :name => "index_6da15d1c9c6370d7a4052d927db51ec7a1b71f9f"

  create_table "manufacturers", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mass_uploads", :force => true do |t|
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.integer  "price"
  end

  create_table "orders", :force => true do |t|
    t.integer  "shipping_address_id"
    t.integer  "invoice_address_id"
    t.integer  "user_id"
    t.text     "basket_serialization"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.date     "estimated_date"
    t.integer  "payment_type"
    t.integer  "discount_used"
    t.integer  "price"
  end

  create_table "photos", :force => true do |t|
    t.integer  "product_id"
    t.string   "image_file", :null => false
    t.string   "alt",        :null => false
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["product_id"], :name => "product"

  create_table "product_sets", :force => true do |t|
    t.integer  "price"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_sets_products", :force => true do |t|
    t.integer  "product_id"
    t.integer  "product_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_sets_properties", :force => true do |t|
    t.integer  "product_set_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_translations", :force => true do |t|
    t.integer  "product_id"
    t.string   "locale"
    t.text     "short_description"
    t.text     "long_description"
    t.text     "advice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_translations", ["locale"], :name => "index_product_translations_on_locale"
  add_index "product_translations", ["product_id"], :name => "index_product_translations_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "name",                             :null => false
    t.string   "short_description"
    t.text     "long_description"
    t.integer  "category_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sku",                              :null => false
    t.integer  "price",                            :null => false
    t.integer  "designer_id"
    t.integer  "manufacturer_id"
    t.string   "slug"
    t.text     "advice"
    t.string   "video"
    t.integer  "brand_id"
    t.integer  "click",             :default => 0
  end

  add_index "products", ["slug"], :name => "index_products_on_slug"

  create_table "products_properties", :force => true do |t|
    t.integer  "property_id", :null => false
    t.integer  "product_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products_properties", ["property_id", "product_id"], :name => "relation", :unique => true

  create_table "products_stores", :force => true do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", :force => true do |t|
    t.string   "property_name",        :null => false
    t.integer  "property_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "num"
  end

  create_table "properties_to_categories", :force => true do |t|
    t.integer  "property_id", :null => false
    t.integer  "category_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties_to_custom_categories", :force => true do |t|
    t.integer  "custom_category_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties_to_line_items", :force => true do |t|
    t.integer  "line_item_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_categories", :force => true do |t|
    t.string   "category_name",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",       :default => true
  end

  add_index "property_categories", ["visible"], :name => "visible"

  create_table "property_categories_to_categories", :force => true do |t|
    t.integer  "property_category_id", :null => false
    t.integer  "category_id",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "property_categories_to_categories", ["property_category_id", "category_id"], :name => "relation", :unique => true

  create_table "property_category_translations", :force => true do |t|
    t.integer  "property_category_id"
    t.string   "locale"
    t.string   "category_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "property_category_translations", ["locale"], :name => "index_property_category_translations_on_locale"
  add_index "property_category_translations", ["property_category_id"], :name => "index_9a9dcff740ab916c9bc8193c91eafe8f63c79e3d"

  create_table "property_translations", :force => true do |t|
    t.integer  "property_id"
    t.string   "locale"
    t.string   "property_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "property_translations", ["locale"], :name => "index_property_translations_on_locale"
  add_index "property_translations", ["property_id"], :name => "index_property_translations_on_property_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "related_products", :force => true do |t|
    t.integer  "product_id",         :null => false
    t.integer  "related_product_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "lat"
    t.string   "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcontent_translations", :force => true do |t|
    t.integer  "subcontent_id"
    t.string   "locale"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcontent_translations", ["locale"], :name => "index_subcontent_translations_on_locale"
  add_index "subcontent_translations", ["subcontent_id"], :name => "index_subcontent_translations_on_subcontent_id"

  create_table "subcontents", :force => true do |t|
    t.integer  "content_id"
    t.string   "name"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "subcontents", ["slug"], :name => "index_subcontents_on_slug"

  create_table "user_addresses", :force => true do |t|
    t.integer  "user_id"
    t.string   "zip",        :null => false
    t.string   "city",       :null => false
    t.string   "street",     :null => false
    t.string   "additional", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin"
    t.string   "title_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "accounting_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wishlist_items", :force => true do |t|
    t.integer  "wishlist_id"
    t.integer  "product_id"
    t.boolean  "sold"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wishlists", :force => true do |t|
    t.string   "custom_url"
    t.integer  "user_id"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
