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

      context "and the customer has checked out" do
        before { click_on "Checkout" }

        scenario "the cart is now empty" do
          expect(page).to have_css(".cart_counter", text: "0")
        end

        scenario "redirects the customer to their order history page after checkout" do
          expect(page).to have_current_path orders_path
        end

        scenario "displays the order in the order history table after checkout" do
          order = Order.first
          expect(page).to have_content order.total_price_in_dollars
        end

        scenario "shows a message to the customer to show that the order was placed after checkout" do
          expect(page).to have_content "Order was successfully placed."
        end
      end
    end
  end
end
