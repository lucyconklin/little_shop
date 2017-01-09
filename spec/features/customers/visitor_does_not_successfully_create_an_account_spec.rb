require 'rails_helper'

feature "A visitor does not successfully create an account" do

  before { visit new_customer_path }

  scenario "the user should see an error message if they do not input all required fields" do
    click_on "Create Account"

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).not_to have_content("Successfully logged in")
  end

  scenario "the user should see an error message if a customer account already exists for that email" do
    create_valid_account
    visit new_customer_path
    invalid_account_creation

    expect(page).to have_content("Email has already been taken")
    expect(page).not_to have_content("Successfully logged in")
  end
end
