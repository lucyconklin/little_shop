require "rails_helper"

feature "When a customer is logged in" do
  before do
    Customer.create!(first_name: "Jane",
                     last_name: "Doe",
                     email: "jane@jane.com",
                     password: "boom")
    visit login_path
    fill_in "email", with: "jane@jane.com"
    fill_in "password", with: "boom"
    within("form") do
      click_on "Log in"
    end
  end

  scenario "they can log out" do
    click_on "Log out"

    expect(current_path).to eql(login_path)
    expect(page).not_to have_css(".navbar", text: "Logged in as Jane Doe")
    expect(page).not_to have_selector(:link_or_button, text: "Log out")
    expect(page).to have_selector(:link_or_button, text: "Log in")
    expect(page).to have_content("Successfully logged out")
  end
end
