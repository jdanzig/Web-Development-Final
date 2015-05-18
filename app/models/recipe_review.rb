class RecipeReview < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  default_scope { order(:created_at => :desc) }
  validates :recipe, :presence => true, :uniqueness => { :scope => :user_id }
  validates :user, :presence => true, :uniqueness => { :scope => :recipe_id }
  validates :rating, :presence => true, :inclusion => { :in => 1..5 }
end