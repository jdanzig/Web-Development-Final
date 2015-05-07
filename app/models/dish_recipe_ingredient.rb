class DishRecipeIngredient < ActiveRecord::Base
  validates :dish_recipe, :presence => true
  validates :ingredient, :presence => true
  validates :quantity, :presence => true, :numericality => {:greater_than => 0}
  as_enum :unit, {0 => :dash, 1 => :tsp, 2 => :tbsp, 3 => :cup, 4 => :pint, 5 => :oz, 6 => :lb}, :source => :unit
end
