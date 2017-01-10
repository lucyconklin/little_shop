require "rails_helper"

feature "Logging in as a customer" do
  context "when a visitor visits the home page" do
    before do
      create(:customer, first_name: "Jane", last_name: "Doe", email: "jane@jane.com")
      visit root_path
    end

    scenario "the visitor should see a log in button or link" do
      expect(page).to have_selector(:link_or_button, "Log in")
    end

    scenario "the visitor should be redirected to the login path after clicking log in" do
      click_on "Log in"

      expect(current_path).to eql(login_path)
    end

    scenario "the customer is redirected to their dashboard page upon logging in" do
      click_on "Log in"
      login

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_selector(:link_or_button, "Log out")
      expect(page).to_not have_selector(:link_or_button, "Log in")
    end

    scenario "the customer should see a successfully logged in message after logging in" do
      click_on "Log in"
      login

      expect(page).to have_content("Successfully logged in")
    end

    scenario "the customer should see a message that tells them they are logged in " do
      click_on "Log in"
      login

      expect(page).to have_css(".navbar", text: "Logged in as Jane Doe")
    end
  end

  context "when a user is already logged in as an admin" do
    before { logged_in_as_current_admin }

    context "logging in as a customer" do
      let!(:customer) { log_in_as_customer }

      scenario "signs them in as a customer" do
        expect(page).to have_current_path(dashboard_path)
        expect(page).to have_content customer.email
      end

      scenario "logs the user out as an admin" do
        visit admin_dashboard_path

        expect(page).to have_content("The page you were looking for doesn't exist.")
      end
    end
  end
end
