require "rails_helper"

feature "When a customer is authenticated" do
  before do
    customer_1, customer_2 = create_list(:customer, 2)
    order_1, order_2, order_3 = create_list(:all_new_order, 3, customer: customer_1)
    @order_4, order_5, order_6 = create_list(:all_new_order, 3, customer: customer_2)
    log_in_as_customer(customer_1)
  end

  scenario "they cannot view another customer's order" do
    visit order_path(order_id: @order_4.id)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
