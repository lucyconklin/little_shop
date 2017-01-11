require "rails_helper"

feature "When a customer is authenticated" do
  let!(:customer_1) { logged_in_as_customer }
  let(:customer_2) { create(:customer_with_orders) }

  scenario "the customer cannot view another customer's orders" do
    order = customer_2.orders.first
    visit order_path(order_id: order.id)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "the customer cannot view the admin dashboard" do
    admin = create(:admin)
    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "the customer cannot edit an admin" do
    admin = create(:admin)
    visit edit_admin_path(admin)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "the customer cannot edit items" do
    item = create(:item)
    visit edit_admin_item_path(item)
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
