class User < ApplicationRecord
  has_many :comments
  #don't allow user with same username up or lowercase
  validates :username, presence: true, uniqueness: {case_sensitive: false},
            length: {minimum: 3, maximum: 25}

  #refer rubular.com for regex
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: {case_sensitive: false},
            length: {maximum: 105}, format: { with: VALID_EMAIL_REGEX }


end
