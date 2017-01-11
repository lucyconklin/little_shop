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

  scenario "they cannot view the admin dashboard" do
    admin = create(:admin)
    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "they cannot edit an admin" do
    admin = create(:admin)
    visit edit_admin_path(admin)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "they cannot edit items" do
    item = create(:item)
    visit edit_admin_item_path(item)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
