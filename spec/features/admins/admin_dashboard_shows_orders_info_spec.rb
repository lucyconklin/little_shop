require 'rails_helper'

feature "Admin dashboard" do
  let!(:admin) { logged_in_as_current_admin }
  let!(:customer) { create(:customer) }

  before do
    paid = Status.create!(name: "paid")
    cancelled = Status.create!(name: "cancelled")
    completed = Status.create!(name: "completed")
    ordered = Status.create!(name: "ordered")

    @order_1 = create(:order, status: paid, customer: customer)
    @order_2, @order_3 = create_list(:order, 2, status: cancelled, customer: customer)
    create_list(:order, 3, status: completed, customer: customer)
    create_list(:order, 4, status: ordered, customer: customer)

    visit admin_dashboard_path
  end

  # scenario "admin logs in to see all orders" do
  #   expect(page).to have_content(customer.first_name)
  #   expect(page).to have_content(customer.last_name)
  #   expect(page).to have_content(customer.id)
  #
  #   expect(page).to have_content(@order_1.status.name.capitalize)
  #   expect(page).to have_content(@order_2.status.name.capitalize)
  #   expect(page).to have_content(@order_3.status.name.capitalize)
  #
  #   expect(page).to have_content(@order_1.total_price_in_dollars)
  #   expect(page).to have_content(@order_2.total_price_in_dollars)
  #   expect(page).to have_content(@order_3.total_price_in_dollars)
  #
  #   expect(page).to have_content(@order_1.date)
  #   expect(page).to have_content(@order_2.date)
  #   expect(page).to have_content(@order_3.date)
  # end
  #
  # scenario "they can see a link to each order" do
  #   expect(page).to have_link("#{@order_1.id}")
  #   expect(page).to have_link("#{@order_2.id}")
  #   expect(page).to have_link("#{@order_3.id}")
  # end
  #
  # scenario "they can see total number of orders by status" do
  #   expect(page).to have_content("Paid - 1")
  #   expect(page).to have_content("Ordered - 4")
  #   expect(page).to have_content("Completed - 3")
  #   expect(page).to have_content("Cancelled - 2")
  # end

  scenario "they can click on 'cancel' to cancel 'paid' or 'ordered' orders" do
    find(".order_#{@order_1.id}_cancel").click

    within(".order_#{@order_1.id}_cancel") { expect(page).to have_content("Cancelled") }
  end

  # xscenario "they can click on 'mark as paid' on orders that are 'ordered'" do
  #   within(:css, ".order_#{order_1.id}") do
  #     click_on "Mark as paid"
  #   end
  #
  #   within("order_#{order_1.id}") { expect(page).to have_content("paid") }
  # end
  #
  # xscenario "they can 'mark as completed' on orders that are 'paid'" do
  #   within(:css, ".order_#{order_1.id}") do
  #     click_on "Mark as completed"
  #   end
  #
  #   within("order_#{order_1.id}") { expect(page).to have_content("completed") }
  # end
  #
  # scenario "they can view all orders on their dashboard page" do
  #   expect(page).to have_css("td", text: "Paid", count: 1)
  #   expect(page).to have_css("td", text: "Cancelled", count: 2)
  #   expect(page).to have_css("td", text: "Completed", count: 3)
  #   expect(page).to have_css("td", text: "Ordered", count: 4)
  # end
  #
  # scenario "they can filter the orders by status" do
  #   within "table" do
  #     find('.dropdown-menu').click
  #     expect(page).not_to have_css(".dropdown-option", text: "Clear filter")
  #     find('.dropdown-option', text: "Paid").click
  #   end
  #
  #   expect(current_path).to eql(admin_dashboard_path)
  #   expect(page).to have_css("td", text: "Paid", count: 1)
  #   expect(page).not_to have_css("td", text: "Cancelled")
  #   expect(page).not_to have_css("td", text: "Completed")
  #   expect(page).not_to have_css("td", text: "Ordered")
  # end
  #
  # scenario "they can clear the filter on orders by status" do
  #   within "table" do
  #     find('.dropdown-menu').click
  #     expect(page).not_to have_css(".dropdown-option", text: "Clear filter")
  #     find('.dropdown-option', text: "Paid").click
  #   end
  #
  #   within "table" do
  #     find('.dropdown-menu').click
  #     find('.dropdown-option', text: "Clear filter").click
  #   end
  #
  #   expect(page).to have_css("td", text: "Paid", count: 1)
  #   expect(page).to have_css("td", text: "Cancelled", count: 2)
  #   expect(page).to have_css("td", text: "Completed", count: 3)
  #   expect(page).to have_css("td", text: "Ordered", count: 4)
  # end
end
