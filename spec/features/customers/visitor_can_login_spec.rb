require "rails_helper"

feature "When a visitor visits the root path" do
  before do
    customer = Customer.create!(first_name: "Jane",
                                last_name: "Doe",
                                email: "jane@jane.com",
                                password: "boom")
    visit root_path
    click_on "Login"
  end

  scenario "they can navigate to the login page and login" do
    fill_in "customer[first_name]", with: "Jane"
    fill_in "customer[last_name]", with: "Doe"
    fill_in "customer[email]", with: "jane@jane.com"
    fill_in "customer[password]", with: "boom"
    click_on "Login"

    expect(current_path).to eql(dashboard_path)
    within "nav" do
      expect(page).to have_content("Logged in as Jane Doe")
    end

  end

  scenario "they see an error message if they leave the email blank" do
    fill_in "customer[password]", with: "boom"
    click_on "Login"

    expect(page).to have_content("Email and password combination do not exist")
  end

  scenario "they see an error message if they leave the password blank" do
    fill_in "customer[email]", with: "jane@jane.com"
    click_on "Login"

    expect(page).to have_content("Email and password combination do not exist")
  end

  scenario "they see an error message if they leave both the email and password blank" do
    customer = Customer.create!(first_name: "Jane",
                                last_name: "Doe",
                                email: "jane@jane.com",
                                password: "boom")
    visit root_path
    click_on "Login"
    click_on "Login"

    expect(page).to have_content("Email and password combination do not exist")
  end

  scenario "they see an error message if they input an invalid email/password combination" do
    fill_in "customer[email]", with: "john@john.com"
    fill_in "customer[password]", with: "boom"
    click_on "Login"

    expect(page).to have_content("Email and password combination do not exist")
  end

  scenario "they can navigate to the Create Account page and create an account" do

  end

  scenario "they see an error message if they do not input all required fields" do

  end

  scenario "they see an error message if a customer account already exists for that email" do

  end

end
