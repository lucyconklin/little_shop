class Item < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price_in_cents, presence: true
  validates :image_url, presence: true
  validates_uniqueness_of :title
  validates :retired, inclusion: { in: [true, false] }

  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  def price_in_dollars(quantity=1)
    quantity * price_in_cents / 100.to_f
  end

  def category_name
    category.name
  end
end
