require 'rails_helper'

RSpec.feature "When a user visits root", type: :feature do
  it "can see index view" do
    visit root_path

    expect(page).to have_content("Timber Shop".upcase)
  end
end
