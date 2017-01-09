require "rails_helper"

feature "When a customer visits the root path" do
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
    fill_in "email", with: "john@john.com"
    fill_in "password", with: "boom"
    within("form") do
      click_on "Log in"
    end

    expect(page).to have_content("Email and password combination do not exist")
    expect(page).not_to have_content("Successfully logged in")
  end

end
