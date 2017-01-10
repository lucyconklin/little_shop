require "rails_helper"

feature "When an admin is logged in" do
  before do
    customer = create(:customer)

    paid = Status.create!(name: "paid")
    cancelled = Status.create!(name: "cancelled")
    completed = Status.create!(name: "completed")
    ordered = Status.create!(name: "ordered")

    create_list(:order, 1, status: paid, customer: customer)
    create_list(:order, 2, status: cancelled, customer: customer)
    create_list(:order, 3, status: completed, customer: customer)
    create_list(:order, 4, status: ordered, customer: customer)

    create(:admin)
    visit admin_login_path
    log_in_as_admin
    visit admin_dashboard_path
  end

  scenario "they can view all orders on their dashboard page" do
    expect(page).to have_css("td", text: "Paid", count: 1)
    expect(page).to have_css("td", text: "Cancelled", count: 2)
    expect(page).to have_css("td", text: "Completed", count: 3)
    expect(page).to have_css("td", text: "Ordered", count: 4)
  end

  scenario "they can filter the orders by status" do
    within "table" do
      find('.dropdown-menu').click
      expect(page).not_to have_css(".dropdown-option", text: "Clear filter")
      find('.dropdown-option', text: "Paid").click
    end

    expect(current_path).to eql(admin_dashboard_path)
    expect(page).to have_css("td", text: "Paid", count: 1)
    expect(page).not_to have_css("td", text: "Cancelled")
    expect(page).not_to have_css("td", text: "Completed")
    expect(page).not_to have_css("td", text: "Ordered")
  end

  scenario "they can clear the filter on orders by status" do
    within "table" do
      find('.dropdown-menu').click
      expect(page).not_to have_css(".dropdown-option", text: "Clear filter")
      find('.dropdown-option', text: "Paid").click
    end

    within "table" do
      find('.dropdown-menu').click
      find('.dropdown-option', text: "Clear filter").click
    end

    expect(page).to have_css("td", text: "Paid", count: 1)
    expect(page).to have_css("td", text: "Cancelled", count: 2)
    expect(page).to have_css("td", text: "Completed", count: 3)
    expect(page).to have_css("td", text: "Ordered", count: 4)
  end
end
