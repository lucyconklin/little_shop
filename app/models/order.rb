class Order < ApplicationRecord

  validates :total_price_in_cents, presence: true

  belongs_to :status
  belongs_to :customer
  has_many :order_items
  has_many :items, through: :order_items
end
