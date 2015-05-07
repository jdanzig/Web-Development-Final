class Ingredient < ActiveRecord::Base
  validates :name, :presence => true
  has_attached_file :picture
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  belongs_to :dish_recipe_ingredient
end