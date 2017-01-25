require "rails_helper"

feature "the admin can update their own data" do
  let!(:admin) { logged_in_as_current_admin }

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
    fill_in "admin[first_name]", with: "Arnold"
    click_on "Submit"

    admin.reload
    expect(page).to have_content("Arnold Boss")
    expect(page).to have_content("jane@admin.com")
    expect(admin.full_name).to eq("Arnold Boss")
  end

  scenario "the admin can update last name" do
    fill_in "admin[last_name]", with: "Schwarzenegger"
    click_on "Submit"

    admin.reload
    expect(page).to have_content("Jane Schwarzenegger")
    expect(page).to have_content("jane@admin.com")
    expect(admin.last_name).to eq("Schwarzenegger")
  end

  scenario "the admin can update email" do
    fill_in "admin[email]", with: "terminator@terminator.com"
    click_on "Submit"
    admin.reload

    expect(page).to have_content("Jane Boss")
    expect(page).to have_content("terminator@terminator.com")
    expect(admin.email).to eq("terminator@terminator.com")
  end

  scenario "the admin can update password" do
    fill_in "admin[current_password]", with: "admin_boom"
    fill_in "admin[password]", with: "jonkimble"
    fill_in "admin[password_confirmation]", with: "jonkimble"
    click_on "Submit"
    admin.reload

    expect(admin.authenticate('admin_boom')).to be false
    expect(admin.authenticate('jonkimble')).to be_a(Admin)
  end
end
