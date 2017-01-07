class Customer < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true
end
