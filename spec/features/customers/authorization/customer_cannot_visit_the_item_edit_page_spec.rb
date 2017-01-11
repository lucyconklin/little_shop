require 'rails_helper'

feature "customer is not authorized to edit an item" do
  let(:item) { create(:item) }

  scenario 'a logged in customer attempts to visit the item edit path' do
    logged_in_as_customer
    visit edit_admin_item_path(item)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
