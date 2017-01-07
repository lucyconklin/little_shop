require 'rails_helper'

describe Order do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:total_price_in_cents) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:order_items) }
    it { is_expected.to have_many(:items).through(:order_items) }
    it { is_expected.to belong_to(:status) }
    it { is_expected.to belong_to(:customer) }
  end

  describe "#total_price_in_dollars" do
    it "returns the price in dollars" do
      order = create(:order, total_price_in_cents: 12_34)

      expect(order.total_price_in_dollars).to eq 12.34
    end
  end

  describe "#date" do
    it "returns a well-formatted date" do
      order_date = DateTime.new(2017, 2, 22, 8)
      order = create(:order, created_at: order_date)

      expect(order.date).to eq "22 Feb 2017"
    end
  end
end
