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

ActiveRecord::Schema.define(version: 20150507045600) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",                 null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "favoritings", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "user_id",   null: false
  end

  add_index "favoritings", ["recipe_id", "user_id"], name: "index_favoritings_on_recipe_id_and_user_id", unique: true

  create_table "recipe_reviews", force: :cascade do |t|
    t.integer  "recipe_id",   null: false
    t.integer  "user_id",     null: false
    t.integer  "rating",      null: false
    t.text     "description"
    t.datetime "created_at",  null: false
  end

  add_index "recipe_reviews", ["recipe_id", "created_at"], name: "index_recipe_reviews_on_recipe_id_and_created_at"
  add_index "recipe_reviews", ["recipe_id", "user_id"], name: "index_recipe_reviews_on_recipe_id_and_user_id", unique: true

  create_table "recipes", force: :cascade do |t|
    t.integer  "category_id",          null: false
    t.string   "name",                 null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.text     "description"
    t.text     "ingredients",          null: false
    t.text     "instructions"
    t.string   "url"
    t.string   "quantity_served"
  end

  add_index "recipes", ["category_id", "name"], name: "index_recipes_on_category_id_and_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                         null: false
    t.string   "last_name",                          null: false
    t.string   "email",                              null: false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.boolean  "uses_oauth",         default: false, null: false
    t.string   "persistence_token",                  null: false
    t.string   "perishable_token",                   null: false
    t.integer  "login_count",        default: 0,     null: false
    t.integer  "failed_login_count", default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

end
