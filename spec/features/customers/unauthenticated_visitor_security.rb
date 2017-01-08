require "rails_helper"

feature "When a site visitor is unauthenticated" do
  before do
    customer = create(:customer)
    @order_1, order_2, order_3 = create_list(:all_new_order, 3, customer: customer)
  end

  scenario "they cannot view a customer's order" do
    visit order_path(order_id: @order_1.id)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
