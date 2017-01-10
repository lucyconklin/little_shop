require "rails_helper"

feature "Admin logs in" do
  before { visit admin_login_path }

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

  describe "when a user is already logged in as a customer" do
    let!(:customer) { log_in_as_customer }

    context "logging in as an admin" do
      before { visit admin_login_path }
      let!(:admin) { log_in_as_admin }

      scenario "signs them in as an admin" do
        expect(page).to have_current_path admin_dashboard_path
        expect(page).to have_content admin.email
        expect(page).to have_content "Logged in as Admin"
      end

      scenario "logs them out as a customer" do
        visit orders_path

        expect(page).to have_content("The page you were looking for doesn't exist.")
      end
    end
  end
end
