class Admin < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
