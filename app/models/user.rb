class User < ActiveRecord::Base
  has_many :favoritings
  has_many :favorite_recipes, :through => :favoritings, :source => :recipe, :class_name => 'Recipe'
  has_many :reviews
  has_many :reviewed_recipes, :through => :reviews, :source => :recipe, :class_name => 'Recipe'
  acts_as_authentic do |aaa|
    aaa.perishable_token_valid_for 1.day
  end

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :email => true, :uniqueness => true

  scope :local_auth, -> { where(:uses_oauth => false) }
  scope :google_auth, -> { where(:uses_oauth => true) }
  scope :with_email, ->(email) { where(:email => email) }

  def self.find_by_smart_case_login_field(email)
    self.local_auth.with_email(email).first
  end

  def require_password?
    !uses_oauth? && super
  end

  def email_addressee
    %{"#{first_name} #{last_name}" <#{email}>}
  end

end