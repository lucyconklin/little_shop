require "rails_helper"

feature "the admin can update their own data" do

  let!(:admin) {logged_in_as_current_admin}

  before do
    visit admin_dashboard_path
    click_on "Edit Profile"
  end

  scenario "the admin can update first name" do

  end

  scenario "the admin can update last name" do

  end

  scenario "the admin can update email" do

  end

  scenario "the admin can update password" do

  end
end
