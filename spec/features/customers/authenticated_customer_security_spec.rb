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
    # When I visit admin_dashboard_path
    # I get a 404
  end

  scenario "the customer cannot edit orders" do
    # When I visit orders_path
    # I get a 404
  end

  scenario "the customer cannot edit an admin" do
    # When I visit edit_admin_path
    # I get a 404
  end

  scenario "the customer cannot edit items" do
    # When I visit edit_admin_item_path
    # I get a 404
  end

  #why do we have an admins#index?
end
