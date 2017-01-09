require "rails_helper"

feature "When a customer is authenticated" do
  let(:customer_2) { create(:customer_with_orders)}

  before do
    logged_in_as_customer
  end

  scenario "they cannot view another customer's order" do
    order = customer_2.orders.first
    visit order_path(order_id: order.id)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
