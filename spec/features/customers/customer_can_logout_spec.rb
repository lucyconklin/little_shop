require "rails_helper"

feature "Log out as a customer" do
  before do
    add_three_items_to_cart
    logged_in_as_customer
    visit root_path
  end

  context "when the customer is logged in" do
    scenario "the customer should view a logged in as message" do
      expect(page).to have_css(".navbar", text: "Logged in as Jane Doe")
    end

    scenario "the customer should view a log out button" do
      expect(page).to have_selector(:link_or_button, text: "Log out")
    end
  end

  context "when the customer has logged out" do
    before { click_on "Log out" }

    scenario "they should see a logged out message" do
      expect(page).to have_content("Successfully logged out")
    end

    scenario "they should then see a log in button or link" do
      expect(page).not_to have_selector(:link_or_button, text: "Log out")
      expect(page).to have_selector(:link_or_button, text: "Log in")
    end

    scenario "there should not be anything in their cart" do
      expect(page).to have_css(".cart_counter", text: "0")
    end
  end
end
