class RecipeReview < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  default_scope { order(:created_at => :desc) }
  validates :recipe, :presence => true
  validates :user, :presence => true
  validates :rating, :presence => true, :inclusion => { :in => 1..5 }
end