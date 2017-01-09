require 'rails_helper'

feature "When a visitor is logged in" do
  before do
    Customer.create!( first_name: "Jane",
                      last_name: "Doe",
                      email: "jane@jane.com",
                      password: "boom")
    visit root_path
    click_on "Log in"
    fill_in "email", with: "jane@jane.com"
    fill_in "password", with: "boom"
    within("form") do
      click_on "Log in"
    end
  end

  scenario "they can click on their name in navbar to go to dashboard page" do
    visit root_path

    click_on("Jane Doe")

    expect(current_path).to eq(dashboard_path)
  end
end
