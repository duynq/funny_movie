require 'bcrypt'

class User < ApplicationRecord
  include BCrypt
  
  has_many :movies, dependent: :destroy

  validates :email, email: true, presence: true
  validates :password_digest, presence: true

  def password
    @password ||= Password.new password_digest
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
