require 'rails_helper'

feature "Admin clicks on an order from dashboard page" do
  let!(:admin) { logged_in_as_current_admin }
  let!(:customer_1) { create(:customer) }
  let!(:customer_2) { create(:customer) }

  before do
    completed = Status.create!(name: "completed")
    ordered = Status.create!(name: "ordered")
    @order_1 = create(:order, customer: customer_1, status: completed)
    @order_2 = create(:order, customer: customer_1, status: completed)
    @order_3 = create(:order, customer: customer_2, status: ordered)
    visit admin_dashboard_path
  end

  scenario "they get to the individual order's path" do
    find(".order_#{@order_1.id}").click

    expect(page).to have_current_path(admin_order_path(@order_1))
  end

  scenario "they can see order's date and time(s)" do
    visit admin_order_path(@order_1)

    expect(page).to have_content(@order_1.date)
    expect(page).to have_content(@order_1.display_submitted_at)
  end

  scenario "they can see purchaser's full name" do
    visit admin_order_path(@order_1)

    expect(page).to have_content(customer_1.full_name)
  end

  scenario "for each item in the order they see item information" do
    visit admin_order_path(@order_1)

    @order_1.items.each do |item|
      expect(page).to have_content(item.title)
      expect(page).to have_content("$#{item.price_in_dollars}")
      expect(page).to have_link("#{item.title}")
    end

    @order_1.items_and_quantities.each do |item, quantity|
      expect(page).to have_content(quantity)
      expect(page).to have_content(item.price_in_dollars(quantity))
    end
  end

  scenario "they can see order information" do
    visit admin_order_path(@order_1)

    expect(page).to have_content(@order_1.status_name)
    expect(page).to have_content("$#{@order_1.total_price_in_dollars}")
  end
end
