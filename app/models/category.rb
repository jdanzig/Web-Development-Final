class Category < ActiveRecord::Base
  has_many :recipes
  validates :name, :presence => true, :uniqueness => true
  has_attached_file :picture
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
end