require 'rails_helper'

feature "Admin dashboard" do
  let!(:admin) { logged_in_as_current_admin }
  let!(:customer) { create(:customer) }
  let!(:order_1) { create(:all_new_order, customer: customer) }
  let!(:order_2) { create(:all_new_order, customer: customer) }
  let!(:order_3) { create(:all_new_order, customer: customer) }

  before do
    visit admin_dashboard_path
  end

  scenario "admin logs in to see all orders" do
    expect(page).to have_content(customer.first_name)
    expect(page).to have_content(customer.last_name)
    expect(page).to have_content(customer.id)

    expect(page).to have_content(order_1.status.name)
    expect(page).to have_content(order_2.status.name)
    expect(page).to have_content(order_3.status.name)

    expect(page).to have_content(order_1.total_price_in_dollars)
    expect(page).to have_content(order_2.total_price_in_dollars)
    expect(page).to have_content(order_3.total_price_in_dollars)

    expect(page).to have_content(order_1.date)
    expect(page).to have_content(order_2.date)
    expect(page).to have_content(order_3.date)
  end

  scenario "they can see a link to each order" do
    expect(page).to have_link("order_#{order_1.id}")
    expect(page).to have_link("order_#{order_2.id}")
    expect(page).to have_link("order_#{order_3.id}")
  end

  scenario "they can see total number of orders by status" do
    skip
  end

  scenario "they can filter orders by status" do
    skip
  end

  scenario "they can click on 'cancel' to cancel paid or ordered orders" do

    within(:css, ".order_#{order_1.id}") do
      click_on "Cancel"
    end

    within("order_#{order_1.id}") { expect(page).to have_content("cancelled") }
  end

  scenario "they can click on 'mark as paid' on orders that are 'ordered'" do
    within(:css, ".order_#{order_1.id}") do
      click_on "Mark as paid"
    end

    within("order_#{order_1.id}") { expect(page).to have_content("paid") }
  end

  scenario "they can 'mark as completed' on orders that are paid" do
    within(:css, ".order_#{order_1.id}") do
      click_on "Mark as completed"
    end

    within("order_#{order_1.id}") { expect(page).to have_content("completed") }
  end
end
