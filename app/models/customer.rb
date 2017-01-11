class Customer < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true

  has_many :orders

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
