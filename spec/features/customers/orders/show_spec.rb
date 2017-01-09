require 'rails_helper'

describe "Viewing one of a customer's order" do
  context "when a customer has an order" do
    scenario "displays the detail page for the order" do
      order_1, order_2, order_3 = create_list(:all_new_order, 3)
      3.times { order_3.items << order_3.items.sample(3) }
      completed = create(:status, name: "completed")
      order_3.update(status: completed)
      customer = log_in_as_customer
      customer.orders = [order_2, order_3]
      visit "/orders"
      click_on("order_#{order_3.id}")

      order_3.items_and_quantities.each do |item, quantity|
        expect(page).to have_selector(:link_or_button, item.title)
        expect(page).to have_content "#{quantity} x $#{item.price_in_dollars}"
        expect(page).to have_content "$#{item.price_in_dollars(quantity)}"
      end

      expect(page).to have_content "Status: #{order_3.status_name}"
      expect(page).to have_content order_3.total_price_in_dollars
      expect(page).to have_content "submitted at: #{order_3.display_submitted_at}"
      expect(page).to have_content "#{order_3.status_name.downcase} at: #{order_3.display_updated_at}"
    end
  end
end
