class Dish < ActiveRecord::Base
  validates :name, :presence => true
  validates :category, :presence => true
  has_many :dish_recipes
  belongs_to :category
  has_attached_file :picture
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
end