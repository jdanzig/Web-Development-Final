class User < ActiveRecord::Base
  has_many :favoritings
  has_many :favorite_recipes, :through => :favoritings, :source => :recipes, :class_name => 'Recipe'
  has_many :reviews
  has_many :reviewed_recipes, :through => :reviews, :source => :recipes, :class_name => 'Recipe'
  acts_as_authentic

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :email => true, :uniqueness => true

  def require_password?
    false
  end

end