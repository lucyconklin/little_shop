require 'rails_helper'

feature "a customer does not have previous orders" do
  let!(:customer) { logged_in_as_customer }

  before { visit orders_path }

  scenario "the customer should view a pleasant message" do
    expect(page).to have_content "You have not placed any orders."
  end
end
