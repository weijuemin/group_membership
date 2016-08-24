class User < ApplicationRecord
  has_secure_password

  has_many :memberships
  has_many :groups, foreign_key: :creator_id

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, presence: true
  validates :email, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
end
