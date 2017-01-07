class OrderItem < ApplicationRecord

  validates :item_price_in_cents, presence: true
  validates :item_quantity, presence: true

  belongs_to :item
  belongs_to :order
end
