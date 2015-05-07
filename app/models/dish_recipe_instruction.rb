class DishRecipeInstruction < ActiveRecord::Base
  include RankedModel
  ranks :row_order, :column => :instruction_order, :scope => :dish_recipe_id
  default_scope { order(:instruction_order) }
  validates :dish_recipe, :presence => true
  validates :instruction, :presence => true

end