require "rails_helper"


feature "When a site visitor is unauthenticated" do
  before do
    # create one customer with orders
  end

  scenario "they cannot view a customer's orders" do
    # make sure the site visitor cannot view the orders of the customer
  end

  scenario "they cannot view admin screens or use admin functionality" do
    # make sure the site visitor gets a 404 when they try to view each admin page
  end

  scenario "they cannot make themselves an admin" do
    # how do we test for this?
  end

  scenario "they are redirected to the login page when they try to check out" do
    # add items to cart
    # visit cart_path
    # click_on "Checkout"

    # expect(current_path).to eql(login_path)
  end
end
