class OrderItem < ApplicationRecord
  before_save :set_price, on: :create

  belongs_to :item
  belongs_to :order

  def set_price
    self.item_price_in_cents = item.price_in_cents
  end
end
