class User < ActiveRecord::Base
  has_many :collections
  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :password, confirmation: true, if: :has_password?
  validates :password_confirmation, presence: true, if: :has_password?

  def has_password?
    false if !self.password
  end
end
