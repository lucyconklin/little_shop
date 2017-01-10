require 'rails_helper'

feature "the customer views the details for an order" do
  let!(:customer) { logged_in_as_customer }
  let!(:order_1) { create(:all_new_order) }
  let!(:order_2) { create(:all_new_order) }
  let!(:order_3) { create(:all_new_order) }

  scenario "the users page path should be /orders " do
    visit orders_path
    expect(page).to have_current_path(orders_path)
  end

  scenario "the user should see the details for the order" do
    create_orders_with_items(order_3)
    update_customer_orders(customer, order_2, order_3)
    visit orders_path
    click_on "#{order_3.id}"

    expect(page).to have_content "Status: #{order_3.status_name}"
    expect(page).to have_content order_3.total_price_in_dollars
    expect(page).to have_content "submitted at: #{order_3.display_submitted_at}"
    expect(page).to have_content "#{order_3.status_name.downcase} at: #{order_3.display_updated_at}"
  end

  scenario "the user should see the items for the order" do
    create_orders_with_items(order_3)
    update_customer_orders(customer, order_2, order_3)
    visit orders_path
    click_on "#{order_3.id}"

    order_3.items_and_quantities.each do |item, quantity|
      expect(page).to have_selector(:link_or_button, item.title)
      expect(page).to have_content "#{quantity} x $#{item.price_in_dollars}"
      expect(page).to have_content "$#{item.price_in_dollars(quantity)}"
    end
  end
end
