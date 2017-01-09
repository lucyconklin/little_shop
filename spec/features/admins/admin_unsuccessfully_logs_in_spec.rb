require 'rails_helper'

feature "Admin sad paths" do

  scenario "Admin enters wrong email" do
    fill_in "email", with: "john@admin.com"
    fill_in "password", with: "admin_boom"
    within("form") do
      click_on "Log in"
    end

    expect(page).to have_current_path(admin_login_path)
    expect(page).to have("Email and password combination do not exist")
  end

  scenario "Admin enters wrong password" do
    fill_in "email", with: "jane@admin.com"
    fill_in "password", with: "boom"
    within("form") do
      click_on "Log in"
    end

    expect(page).to have_current_path(admin_login_path)
    expect(page).to have("Email and password combination do not exist")
  end

  scenario "both fields are blank" do
    within("form") do
      click_on "Log in"
    end

    expect(page).to have_current_path(admin_login_path)
    expect(page).to have("Email and password combination do not exist")
  end
end
