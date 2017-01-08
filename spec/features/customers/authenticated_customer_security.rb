require "rails_helper"


feature "When a customer is authenticated" do
  before do
    #create two customers with orders
    #log the first customer in
  end

  scenario "they cannot view another customer's orders" do
    #make sure the logged in customer cannot view the orders of the 2nd customer
  end

  scenario "they cannot view admin screens or use admin functionality" do
    #make sure the logged in customer gets a 404 when they try to view each admin page
  end

  scenario "they cannot make themselves an admin" do
    #how do we test for this?
  end
end
