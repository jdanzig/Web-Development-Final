class RecipeInstruction < ActiveRecord::Base
  belongs_to :recipe
  include RankedModel
  ranks :row_order, :column => :instruction_order, :scope => :dish_recipe_id
  default_scope { order(:instruction_order) }
  validates :recipe, :presence => true
  validates :instruction, :presence => true
end