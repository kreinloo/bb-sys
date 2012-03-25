# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  username        :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base

  attr_accessible :username, :email, :password, :password_confirmation

  has_secure_password

  has_many :posts

  has_many :replies

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { in: 3..20 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: VALID_EMAIL_REGEX }

  validates :password,
    length: { minimum: 6 }

  validates :password_confirmation,
    presence: true

end
