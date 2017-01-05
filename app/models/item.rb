class Item < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price_in_cents, presence: true
  validates :image_url, presence: true
  validates_uniqueness_of :title

  belongs_to :category

  def price_in_dollars
    price_in_cents / 100.to_f
  end

  def category_name
    category.name
  end
end
