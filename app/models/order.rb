class Order < ApplicationRecord

  validates :total_price_in_cents, presence: true
  validates :status, presence: true
  validates :customer, presence: true
  validates :items, presence: true

  belongs_to :status
  belongs_to :customer
  has_many :order_items
  has_many :items, through: :order_items

  def total_price_in_dollars
    total_price_in_cents / 100.to_f
  end

  def date
    created_at.strftime("%e %b %Y")
  end
end
