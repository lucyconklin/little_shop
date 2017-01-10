require 'rails_helper'

describe "Viewing a customer's previous orders" do
  context "a customer has no orders" do
    scenario "a pleasant message appears" do
      logged_in_as_customer
      visit "/orders"

      expect(page).to have_content "You have not placed any orders."
    end
  end

  context "a customer has previous orders" do
    scenario "those orders appear as a table" do
      customer = logged_in_as_customer
      order_1, order_2, order_3 = create_list(:all_new_order, 3)
      customer.orders = [order_1, order_2]
      visit "/orders"

      expect(page).to have_content "$#{order_1.total_price_in_dollars}"
      expect(page).to have_content order_1.date
      expect(page).to have_content "$#{order_2.total_price_in_dollars}"
      expect(page).to have_content order_2.date
      expect(page).not_to have_content "$#{order_3.total_price_in_dollars}"
    end
  end
end
