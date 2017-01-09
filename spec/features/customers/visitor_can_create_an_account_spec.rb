require 'rails_helper'

feature 'A visitor can create an account' do

  before { visit root_path }

  scenario "the user clicks on log in" do
    click_on "Log in"
    expect(page).to have_current_path(login_path)
  end

  scenario 'the user should see the link or button to register' do
    visit login_path
    expect(page).to have_selector(:link_or_button, "Register")
  end

  scenario "the user then clicks on register/create account and is redirected to the new customer path " do
    visit login_path
    click_on "Register"

    expect(current_path).to eql(new_customer_path)
  end

  scenario "when the user creates an account they should be routed to their dashboard page" do
    visit new_customer_path
    create_valid_account

    expect(current_path).to eql(dashboard_path)
  end

  scenario 'the user should see their profile information' do
    visit new_customer_path
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
    visit new_customer_path
    create_valid_account

    expect(page).not_to have_selector(:link_or_button, text: "Log in")
    expect(page).to have_selector(:link_or_button, text: "Log out")
  end

end
