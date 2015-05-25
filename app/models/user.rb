class User < ActiveRecord::Base
  has_many :favoritings
  has_many :favorite_recipes, :through => :favoritings, :source => :recipes, :class_name => 'Recipe'
  has_many :reviews
  has_many :reviewed_recipes, :through => :reviews, :source => :recipes, :class_name => 'Recipe'
  acts_as_authentic

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :email => true, :uniqueness => true

  scope :local_auth, { where(:uses_oauth => false) }
  scope :google_auth, { where(:uses_oauth => true) }

  def self.find_by_smart_case_login_field(email)
    self.class.local_auth.where(:email => email).first
  end

  def require_password?
    uses_oauth? && super
  end

end