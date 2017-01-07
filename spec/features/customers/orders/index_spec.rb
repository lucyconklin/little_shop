require 'rails_helper'

describe "Viewing a customer's previous orders" do
  context "a customer has no orders" do
    scenario "a pleasant message appears" do
      customer = create(:customer)
      visit "/orders"

      expect(page).to have_content "You have not placed any orders."
    end
  end

  context "a customer has previous orders" do
    scenario "those orders appear as a list" do
      customer = create(:customer)
      order_1, order_2 = create_list(:order, 2)
      customer.orders = [order_1, order_2]
      visit "/orders"

      expect(page).to have_content "$#{order_1.total_price_in_dollars}"
      expect(page).to have_content order_1.date
      expect(page).to have_content "$#{order_2.total_price_in_dollars}"
      expect(page).to have_content order_2.date
    end
  end
end
