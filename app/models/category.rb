class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :items

  scope :sort_by_name, -> { order 'name' }
end
