class Initial < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :null => false, :unique => true
      t.attachment :picture
    end

    create_table :recipes do |t|
      t.integer :category_id, :null => false
      t.string :name, :null => false
      t.attachment :picture
      t.text :description
      t.string :url
      t.string :quantity_served
    end
    add_index :recipes, [:category_id, :name], :unique => true
    add_foreign_key :recipes, :categories

    create_table :recipe_ingredients do |t|
      t.integer :recipe_id, :null => false
      t.string :description, :null => false
    end
    add_index :recipe_ingredients, [:recipe_id, :description], :unique => true
    add_foreign_key :recipe_ingredients, :recipes
    
    create_table :recipe_instructions do |t|
      t.integer :recipe_id, :null => false
      t.text :instruction, :null => false
      t.integer :instruction_order, :null => false
    end
    add_index :recipe_instructions, [:recipe_id, :instruction_order], :name => 'index_dri_on_dr_id_and_io'
    add_foreign_key :recipe_instructions, :recipes

    create_table :users do |t|
      # From https://github.com/binarylogic/authlogic_example/tree/master
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false, :unique => true # optional, you can use login instead, or both
      t.string :crypted_password
      t.string :password_salt
      t.boolean :uses_oauth, :null => false, :default => false
      t.string :persistence_token, :null => false # required
      t.integer :login_count, :null => false, :default => 0
      t.integer :failed_login_count, :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
    end

    create_table :favoritings do |t|
      t.integer :recipe_id, :null => false
      t.integer :user_id, :null => false
    end
    add_index :favoritings, [:recipe_id, :user_id], :unique => true
    add_foreign_key :favoritings, :recipes
    add_foreign_key :favoritings, :users

    create_table :recipe_reviews do |t|
      t.integer :recipe_id, :null => false
      t.integer :user_id, :null => false
      t.integer :rating, :null => false
      t.text :description
      t.datetime :created_at, :null => false
    end
    add_index :recipe_reviews, [:recipe_id, :user_id], :unique => true
    add_index :recipe_reviews, [:recipe_id, :created_at], :unique => false, :order => {:recipe_id => :asc, :created_at => :desc}
    add_foreign_key :recipe_reviews, :recipes
    add_foreign_key :recipe_reviews, :users 
  end
end
