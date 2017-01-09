require "rails_helper"

feature "When a visitor visits the root path" do
  before do
    Customer.create!( first_name: "Jane",
                      last_name: "Doe",
                      email: "jane@jane.com",
                      password: "boom")
    visit root_path
    click_on "Log in"
  end

  scenario "they can navigate to the login page and log in" do
    fill_in "email", with: "jane@jane.com"
    fill_in "password", with: "boom"
    within("form") do
      click_on "Log in"
    end

    expect(current_path).to eql(dashboard_path)
    expect(page).to have_css(".navbar", text: "Logged in as Jane Doe")
    expect(page).to have_content("Successfully logged in")
  end

  scenario "they see an error message if they leave the email blank" do
    fill_in "password", with: "boom"
    within("form") do
      click_on "Log in"
    end

    expect(page).to have_content("Email and password combination do not exist")
    expect(page).not_to have_content("Successfully logged in")
  end

  scenario "they see an error message if they leave the password blank" do
    fill_in "email", with: "jane@jane.com"
    within("form") do
      click_on "Log in"
    end

    expect(page).to have_content("Email and password combination do not exist")
    expect(page).not_to have_content("Successfully logged in")
  end

  scenario "they see an error message if they leave both the email and password blank" do
    within("form") do
      click_on "Log in"
    end

    expect(page).to have_content("Email and password combination do not exist")
    expect(page).not_to have_content("Successfully logged in")
  end

  scenario "they see an error message if they input an invalid email/password combination" do
    fill_in "email", with: "jane@jane.com"
    fill_in "password", with: "wrong"
    within("form") do
      click_on "Log in"
    end

    expect(page).to have_content("Email and password combination do not exist")
    expect(page).not_to have_content("Successfully logged in")
  end

  scenario "they can navigate to the Create Account page and create an account" do
    click_on "Register"

    expect(current_path).to eql(new_customer_path)
    expect(page).to have_content("Create Your Account")

    fill_in "customer[first_name]", with: "John"
    fill_in "customer[last_name]", with: "Smith"
    fill_in "customer[email]", with: "john@john.com"
    fill_in "customer[password]", with: "boom"
    fill_in "customer[password_confirmation]", with: "boom"
    click_on "Create Account"

    expect(current_path).to eql(dashboard_path)
    expect(page).to have_css(".navbar", text: "Logged in as John Smith")
    expect(page).to have_content("Successfully logged in")
    expect(page).to have_content("Account Information")
    expect(page).to have_content("First name: John")
    expect(page).to have_content("Last name: Smith")
    expect(page).to have_content("Email: john@john.com")
    expect(page).not_to have_selector(:link_or_button, text: "Log in")
    expect(page).to have_selector(:link_or_button, text: "Log out")
  end

  scenario "they see an error message if they do not input all required fields" do
    click_on "Register"
    click_on "Create Account"

    expect(current_path).to eql(customers_path)

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).not_to have_content("Successfully logged in")
  end

  scenario "they see an error message if a customer account already exists for that email" do
    click_on "Register"

    expect(current_path).to eql(new_customer_path)
    expect(page).to have_content("Create Your Account")

    fill_in "customer[first_name]", with: "John"
    fill_in "customer[last_name]", with: "Smith"
    fill_in "customer[email]", with: "jane@jane.com"
    fill_in "customer[password]", with: "blue"
    click_on "Create Account"

    expect(current_path).to eql(customers_path)
    expect(page).to have_content("Email has already been taken")
    expect(page).not_to have_content("Successfully logged in")
  end
end
