require "rails_helper"

feature "When a visitor visits the root path" do
  scenario "they can navigate to the create account form and create an account" do
    visit root_path
    click_on "Login"

    expect(current_path).to eql(login_path)

    click_on "Login"

    expect(page).to have_content("Email and password combination do not exist")

    click_on "Create Account"

    expect(current_path).to eql(new_customer_path)

    fill_in "customer[first_name]", with: "Jane"
    fill_in "customer[last_name]", with: "Doe"
    fill_in "customer[email]", with: "jane@jane.com"
    fill_in "customer[password]", with: "boom"

    click_on "Create Account"

    expect(current_page).to eql(dashboard_path)
    within "nav" do
      expect(page).to have_content("Logged in as Jane Doe")
    end
    expect(page).to have_content("Account Information")
    expect(page).to have_content("Jane Doe")
    expect(page).not_to have_selector(:link_or_button, "Login")
    expect(page).to have_selector(:link_or_button, "Logout")
  end

end
