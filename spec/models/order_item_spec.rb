require 'rails_helper'

describe OrderItem do
  describe 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:item) }
  end

  describe "before saving" do
    let!(:items) { create_list(:item, 2) }
    let!(:order) { create(:all_new_order, items: items) }

    context "saves the item price" do
      it "returns the price of the item in cents" do
        order_items = order.order_items

        expect(order_items.pluck(:item_price_in_cents)).to match_array items.map(&:price_in_cents)
      end
    end
  end
end
