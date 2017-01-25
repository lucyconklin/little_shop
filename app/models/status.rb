class Status < ApplicationRecord
  validates :name, presence: true

  has_many :orders

  scope :sort_by_name, -> { order 'name' }

  def count_of_orders
    orders.count
  end

  def paid?
    name == "paid"
  end
end
