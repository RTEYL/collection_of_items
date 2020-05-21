class User < ActiveRecord::Base
  has_many :collections
  has_many :items, through: :collections
  has_secure_password
  validates :name, :password_confirmation, presence: true, length: {minimum: 3, maximum: 12}
  validates :password, confirmation: true, length: {minimum: 3, maximum: 12}
end
