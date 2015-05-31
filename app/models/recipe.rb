class Recipe < ActiveRecord::Base
  belongs_to :category
  has_many :instructions, :class_name => 'RecipeInstruction'
  has_many :ingredients, :class_name => 'RecipeIngredient'
  has_many :favoritings # A favoriting relationship
  has_many :favoriters, :class_name => 'User', :through => :favoritings, :source => :user
  has_many :reviews, :class_name => 'RecipeReview'
  has_many :reviewers, :class_name => 'User', :through => :reviews, :source => :user
  
  validates :name, :presence => true, :uniqueness => {:scope => :category_id}
  validates :category, :presence => true
  has_attached_file :picture
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates :quantity_served, :presence => true
  validates :url, :presence => true, :url => true, :if => ->(recipe) { recipe.instructions.empty? }
  validates :instructions, :length => {:minimum => 1}, :unless => :url?
end