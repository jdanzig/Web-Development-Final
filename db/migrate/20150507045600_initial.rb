class Initial < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :null => false
      t.string :ancestry, :null => false
    end
    add_index :categories, :ancestry
    add_index :categories, [:name, :ancestry], :unique => true

    create_table :ingredients do |t|
      t.string :name, :null => false
      t.text :description
      t.attachment :picture
    end

    create_table :dishes do |t|
      t.integer :category_id, :null => false
      t.string :name, :null => false
      t.attachment :picture
    end
    add_index :dishes, [:category_id, :name], :unique => true
    add_foreign_key :dishes, :categories

    create_table :dish_recipes do |t|
      t.integer :dish_id, :null => false
      t.text :description, :null => false
    end
    add_foreign_key :dish_recipes, :dishes

    create_table :dish_recipe_ingredients do |t|
      t.integer :dish_recipe_id, :null => false
      t.integer :ingredient_id, :null => false
      t.integer :quantity, :null => false
      t.integer :unit
    end
    add_index :dish_recipe_ingredients, [:dish_recipe_id, :ingredient_id], :unique => true, :name => 'index_dri_on_dr_id_and_i_id'
    add_foreign_key :dish_recipe_ingredients, :dish_recipes
    add_foreign_key :dish_recipe_ingredients, :ingredients

    create_table :dish_recipe_instructions do |t|
      t.integer :dish_recipe_id, :null => false
      t.text :instruction, :null => false
      t.integer :instruction_order, :null => false
    end
    add_index :dish_recipe_instructions, [:dish_recipe_id, :instruction_order], :name => 'index_dri_on_dr_id_and_io'
    add_foreign_key :dish_recipe_instructions, :dish_recipes

  end
end
