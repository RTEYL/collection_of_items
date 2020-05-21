class User < ActiveRecord::Base
  has_many :collections
  has_many :items, through: :collections
  has_secure_password
  validates :username, :password_confirmation, presence: true
  validates :password, confirmation: true
end
