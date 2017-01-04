class Item < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price_in_cents, presence: true
  validates :image_url, presence: true
  validates_uniqueness_of :title
  validates_uniqueness_of :image_url

  belongs_to :category
end
