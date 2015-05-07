class DishRecipe < ActiveRecord::Base
  validates :dish, :presence => true
  validates :description, :presence => true
  belongs_to :dish
  has_many :ingredients, :class_name => 'DishRecipeIngredient'
  has_many :instructions, :class_name => 'DishRecipeInstructions'
end