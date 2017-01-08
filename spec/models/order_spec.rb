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
      item = create(:item, price_in_cents: 12_34)
      order = create(:all_new_order, items: [item])

      expect(order.total_price_in_dollars).to eq 12.34
    end
  end

  describe "#calculated_price_in_cents" do
    let!(:item_1) { create(:item, price_in_cents: 11_11) }
    let!(:item_2) { create(:item, price_in_cents: 10_00) }

    context "there is one item on the order" do
      it "returns the price of that one item" do
        items = [item_1]
        order = create(:all_new_order, items: items)

        expect(order.calculated_price_in_cents).to eq 11_11
        expect(order.total_price_in_cents).to eq 11_11
      end
    end

    context "there are two unique items" do
      it "returns the total price of those two items added together" do
        items = [item_1, item_2]
        order = create(:all_new_order, items: items)

        expect(order.calculated_price_in_cents).to eq 21_11
        expect(order.total_price_in_cents).to eq 21_11
      end

    end

    context "there are multiple items with different quantities" do
      it "returns the total price for the order" do
        items = [item_1, item_1, item_2, item_2, item_2]
        order = create(:all_new_order, items: items)

        expect(order.calculated_price_in_cents).to eq 52_22
        expect(order.total_price_in_cents).to eq 52_22
      end
    end
  end

  describe "price_in_cents" do
    let(:item_1) { create(:item, price_in_cents: 11_11) }
    let(:item_2) { create(:item, price_in_cents: 20_02) }

    it "returns the total price of all the items on the order" do
      items = [item_1, item_1, item_1, item_2, item_2]
      order = create(:all_new_order, items: items)

      expect(order.total_price_in_cents).to eq 73_37
      expect(order.calculated_price_in_cents).to eq 73_37
    end
  end

  describe "#date" do
    it "returns a well-formatted date" do
      order_date = DateTime.new(2017, 2, 22, 8)
      order = create(:all_new_order, created_at: order_date)

      expect(order.date).to eq "22 Feb 2017"
    end
  end

  describe "#items_and_quantities" do
    it "returns the items and the quantities" do
      item_1, item_2 = create_list(:item, 2)
      items = [item_1, item_1, item_1, item_2]
      order = create(:all_new_order, items: items)

      expect(order.items_and_quantities).to include(item_1 => 3, item_2 => 1)
    end
  end

  describe "#status_name" do
    it "returns the name of the status" do
      status = create(:status, name: "paid")
      order = create(:all_new_order, status: status)

      expect(order.status_name).to eq "Paid"
    end
  end

  describe "#completed_or_cancelled?" do
    let(:completed) { create(:status, name: "completed") }
    let(:cancelled) { create(:status, name: "cancelled") }
    let(:paid) { create(:status, name: "paid") }

    it "returns true when the order has a status of completed" do
      order = create(:all_new_order, status: completed)

      expect(order.completed_or_cancelled?).to be true
    end

    it "returns true when the order has a status of cancelled" do
      order = create(:all_new_order, status: cancelled)

      expect(order.completed_or_cancelled?).to be true
    end

    it "returns false when the status is not completed or cancelled" do
      order = create(:all_new_order, status: paid)

      expect(order.completed_or_cancelled?).to be false
    end
  end

  describe "#display_submitted_at" do
    let(:order) { create(:all_new_order) }
    let(:submitted_at) { DateTime.new(2017, 2, 22, 8, 22) }
    it "returns a nicely formatted date-time" do
      order.update(created_at: submitted_at)

      expect(order.display_submitted_at).to eq "22 Feb 2017 at  8:22 AM"
    end
  end

  describe "#display_updated_at" do
    let(:order) { create(:all_new_order) }
    let(:updated_at) { DateTime.new(2017, 2, 24, 8, 24) }
    it "returns a nicely formatted date-time" do
      order.update(created_at: updated_at)

      expect(order.display_updated_at).to eq "24 Feb 2017 at  8:24 AM"
    end
  end
end
