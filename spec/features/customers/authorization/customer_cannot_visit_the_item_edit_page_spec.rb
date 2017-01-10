require 'rails_helper'

feature "customer is not authorized to edit an item" do
  let(:customer) { logged_in_as_current_customer }
  let(:item) { create(:item) }

  scenario 'a logged in customer attempts to visit the item edit path' do
    logged_in_as_current_customer
    visit edit_admin_item_path(item)

    expect(page).to_not have_current_path(edit_admin_item_path(item))
    expect(page).to have_current_path(admin_login_path)
  end
end
