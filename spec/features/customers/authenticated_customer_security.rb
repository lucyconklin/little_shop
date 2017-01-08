require "rails_helper"


feature "When a customer is authenticated" do
  before do
    customer1 = Customer.create!( first_name: "Jane",
                                  last_name: "Doe",
                                  email: "jane@jane.com",
                                  password: "boom")
    customer2 = create(:customer)
    status = create(:status)
    @order1, @order2, @order3 = create_list(:order, 3, customer: customer1)
    @order4, @order5, @order6 = create_list(:order, 3, customer: customer2)

    visit login_path
    fill_in "email", with: "jane@jane.com"
    fill_in "password", with: "boom"
    within("form") do
      click_on "Log in"
    end
  end

  scenario "they cannot view another customer's orders" do
    visit order_path(order_id: @order4.id)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  # scenario "they cannot view admin screens or use admin functionality" do
  #   #make sure the logged in customer gets a 404 when they try to view each admin page
  #   visit "???"
  #
  #   expect(response.status).to eql(404)
  #   expect(page).to have_css(".alert-error", text: "The page you were looking for doesn\'t exist.")
  # end
  #
  # scenario "they cannot make themselves an admin" do
  #   #how do we test for this?
  # end
end
