require "rails_helper"

feature "When a customer is authenticated" do
  let!(:customer_1) { logged_in_as_customer }
  let(:customer_2) { create(:customer_with_orders)}

  scenario "customer 1 cannot view customer 2's orders" do
    order = customer_2.orders.first
    visit order_path(order_id: order.id)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
