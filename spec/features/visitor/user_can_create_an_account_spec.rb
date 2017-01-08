require 'rails_helper'

feature 'A visitor can create an account' do

  before { visit new_customer_path }

  scenario 'the current path should be customers/new' do
    expect(current_path).to eql(new_customer_path)
  end

  scenario 'the user should see a link or button to create and account' do
    expect(page).to have_button("Create Account")
  end

  scenario "when the user creates an account they should be routed to their dashboard page" do
    create_valid_account

    expect(current_path).to eql(dashboard_path)
  end

  scenario 'the user should see their profile information' do
    create_valid_account

    expect(current_path).to eql(dashboard_path)
    expect(page).to have_css(".navbar", text: "Logged in as John Smith")
    expect(page).to have_content("Successfully logged in")
    expect(page).to have_content("Account Information")
    expect(page).to have_content("First name: John")
    expect(page).to have_content("Last name: Smith")
    expect(page).to have_content("Email: john@john.com")
  end

  scenario 'the dashboard path should have a log out button and not a log in button' do
    create_valid_account

    expect(page).not_to have_selector(:link_or_button, text: "Log in")
    expect(page).to have_selector(:link_or_button, text: "Log out")
  end

end
