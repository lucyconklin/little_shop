require "rails_helper"

feature "When an admin is logged in" do
  before { visit admin_login_path }
  let!(:admin) { log_in_as_admin }

  context "and they wish to log out" do
    scenario "the admin should view a log out button" do
      expect(page).to have_selector(:link_or_button, text: "Log out")
    end
  end

  context "after the admin logs out" do
    before { click_on "Log out" }

    scenario "they see a logged out message" do
      expect(page).to have_content("Successfully logged out")
    end

    scenario "they see a link to log in as a customer" do
      expect(page).not_to have_selector(:link_or_button, text: "Log out")
      expect(page).to have_selector(:link_or_button, text: "Log in")
    end

    scenario "they no longer see logged in as admin in navbar" do
      expect(page).not_to have_content "Logged in as Admin: #{admin.first_name}"
    end
  end
end
