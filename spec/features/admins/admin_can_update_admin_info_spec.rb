require "rails_helper"
 p
feature "the admin can update their own data" do

  let!(:admin) {logged_in_as_current_admin}

  before do
    visit admin_dashboard_path
    click_on "Edit Profile"
  end

  scenario "the admin goes to edit page" do
    expect(page).to have_content("Edit")
    expect(page).to have_current_path(edit_admin_path(admin))
  end

  scenario "on submit they are redirected back to dashboard" do
    click_on "Submit"

    expect(page).to have_current_path(admin_dashboard_path)
  end

  scenario "the admin can update first name" do
    fill_in "First name", with: "Arnold"
    click_on "Submit"

    expect(page).to have_content("Arnold Boss")
    expect(page).to have_content("jane@admin.com")
  end

  xscenario "the admin can update last name" do
    fill_in "Last name", with: "Schwarzenegger"
    click_on "Submit"

    expect(page).to have_current_path(admin_dashboard_path)
    expect(page).to have_content("Jane Schwarzenegger")
    expect(page).to have_content("jane@admin.com")
  end

  xscenario "the admin can update email" do
    fill_in "email", with: "terminator@terminator.com"
    click_on "Submit"

    expect(page).to have_current_path(admin_dashboard_path)
    expect(page).to have_content("Jane Boss")
    expect(page).to have_content("terminator@terminator.com")
  end

  xscenario "the admin can update password" do
    expect(admin.password).to eq("admin_boom")
    fill_in "current password", with: "admin_boom"
    fill_in "password", with: "jonkimble"
    fill_in "confirm password", with: "jonkimble"
    click_on "Submit"

    expect(admin.password).to eq("jonkimble")
  end
end
