class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  validates :recipe, :presence => true
  validates :description, :presence => true, :uniqueness => {:scope => :recipe_id}
end
