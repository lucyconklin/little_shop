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

  def items_and_quantities
    items.reduce(Hash.new(0)) do |hash, item|
      hash[item] += 1
      hash
    end
  end

  def status_name
    status.name.capitalize
  end

  def completed_or_cancelled?
    status.name == "completed" || status.name == "cancelled"
  end

  def display_submitted_at
    created_at.strftime('%e %b %Y at %l:%M %p')
  end

  def display_updated_at
    created_at.strftime('%e %b %Y at %l:%M %p')
  end
end
