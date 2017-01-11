require 'rails_helper'

describe "Cart checkout" do
  context "as a logged in user" do
    let!(:item) { add_three_items_to_cart }
    before do
      create(:status, name: "ordered")
      logged_in_as_customer
      visit cart_path
    end

    context "there are items in the cart" do
      context "but the customer has not checked out" do
        scenario "shows the Checkout button" do
          expect(page).to have_content(:link_or_button, "Checkout")
        end

        scenario "creates an order which contains the contents of the cart" do
          expect { click_on "Checkout" }.to change { Order.count }.from(0).to(1)

          order = Order.first
          expect(order.items).to match_array [item, item, item]
        end
      end
    end
  end
end
