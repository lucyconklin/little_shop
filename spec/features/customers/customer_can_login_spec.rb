require "rails_helper"

feature "When a customer visits the root path" do
  before do
    create(:customer, first_name: "Jane", last_name: "Doe", email: "jane@jane.com")
    visit root_path
  end

  scenario "the customer should see a log in button or link" do
    expect(page).to have_selector(:link_or_button, "Log in")
  end

  scenario "the customer should be redirected to the login path after clicking log in" do
    click_on "Log in"

    expect(current_path).to eql(login_path)
  end

  scenario "the user is redirected to their dashboard page upon logging in" do
    click_on "Log in"
    login

    expect(page).to have_current_path(dashboard_path)
  end

  scenario "the user should see a successfully logged in message after logging in" do
    click_on "Log in"
    login

    expect(page).to have_content("Successfully logged in")
  end

  scenario "the user should see a message that tells them they are logged in " do
    click_on "Log in"
    login

    expect(page).to have_css(".navbar", text: "Logged in as Jane Doe")
  end

end
