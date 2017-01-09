require "rails_helper"

feature "When a visitor visits the admin log in path" do
  before do
    Admin.create!(first_name: "Jane",
                  last_name: "Admin",
                  email: "jane@admin.com",
                  password: "admin_boom")
    visit admin_login_path # '/admin'
  end

  scenario "they can log in" do
    fill_in "email", with: "jane@admin.com"
    fill_in "password", with: "admin_boom"
    within("form") do
      click_on "Log in"
    end

    expect(current_path).to eql(admin_dashboard_path)
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_css(".navbar", text: "Logged in as Admin Jane Admin")
    expect(page).to have_content("Successfully logged in")
  end
