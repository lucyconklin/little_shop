require 'rails_helper'

describe OrderProcessor do
  let!(:customer) { create(:customer) }
  let!(:item_1) { create(:item) }
  let!(:item_2) { create(:item) }
  let!(:cart) { Cart.new({item_1.id.to_s => 2, item_2.id.to_s => 3}) }
  let!(:status) { create(:status, name: "ordered") }
  let(:order_processor) { OrderProcessor.new }

  it "initializes a new order with status 'ordered'" do
    expect(order_processor.order.status_name).to eq "Ordered"
  end

  describe "#process" do
    it "assigns the contents of the cart as items on the order" do
      expect { order_processor.process(customer, cart.items) }
        .to change { order_processor.order.items.count }
        .from(0).to(5)
    end

    it "saves the order" do
      expect { order_processor.process(customer, cart.items) }
        .to change { Order.count }
        .from(0).to(1)
    end
  end
end
