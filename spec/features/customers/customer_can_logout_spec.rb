require "rails_helper"

feature "When a customer is logged in" do
  before do
    logged_in_as_customer
    visit root_path
  end

  scenario "the customer should view a logged in as message" do
    expect(page).to have_css(".navbar", text: "Logged in as Jane Doe")
  end

  scenario "the customer should view a log out button" do
    expect(page).to have_selector(:link_or_button, text: "Log out")
  end

  scenario "after the customer clicks on the log out button or link they should see a logged out message" do
    click_on "Log out"

    expect(page).to have_content("Successfully logged out")
  end

  scenario "after the customer clicks on the log out button or link they should then see a log in button or link" do
    click_on "Log out"

    expect(page).not_to have_selector(:link_or_button, text: "Log out")
    expect(page).to have_selector(:link_or_button, text: "Log in")
  end
end
