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
    t.string "name",     null: false
    t.string "ancestry", null: false
  end

  add_index "categories", ["name", "ancestry"], name: "index_categories_on_name_and_ancestry", unique: true

  create_table "dish_recipe_ingredients", force: :cascade do |t|
    t.integer "dish_recipe_id", null: false
    t.integer "ingredient_id",  null: false
    t.integer "quantity",       null: false
    t.integer "unit",           null: false
  end

  add_index "dish_recipe_ingredients", ["dish_recipe_id", "ingredient_id"], name: "index_dri_on_dr_id_and_i_id", unique: true

  create_table "dish_recipe_instructions", force: :cascade do |t|
    t.integer "dish_recipe_id",    null: false
    t.text    "instruction",       null: false
    t.integer "instruction_order", null: false
  end

  add_index "dish_recipe_instructions", ["dish_recipe_id", "instruction_order"], name: "index_dri_on_dr_id_and_io"

  create_table "dish_recipes", force: :cascade do |t|
    t.integer "dish_id",     null: false
    t.text    "description", null: false
  end

  create_table "dishes", force: :cascade do |t|
    t.integer  "category_id",          null: false
    t.string   "name",                 null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "dishes", ["category_id", "name"], name: "index_dishes_on_category_id_and_name", unique: true

  create_table "ingredients", force: :cascade do |t|
    t.string   "name",                 null: false
    t.text     "description"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

end
