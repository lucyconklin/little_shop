require "rails_helper"

feature "Admin logs in" do
  before do
    create(:admin)
    visit admin_login_path
  end

  scenario "successful login goes to admin dashboard page" do
    log_in_as_admin

    expect(page).to have_current_path(admin_dashboard_path)
  end

  scenario "page indicates admin is logged in as admin" do
    log_in_as_admin

    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_css(".navbar", text: "Logged in as Admin: Jane Boss")
    expect(page).to have_content("Successfully logged in")
  end

  scenario "after logging in the session[admin_id] should be set" do
    log_in_as_admin
    session = page.get_rack_session["admin_id"]

    expect(session).to eq(Admin.first.id)
  end
end
