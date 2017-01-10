require 'rails_helper'

feature 'the admin updates a item' do
  context 'when the admin visits admin/items' do
    let!(:admin) { logged_in_as_current_admin }
    let(:item) { Item.first }
    before do
      create(:category_with_items)
      visit items_path(admin)
    end

    scenario 'the admin should see a edit button' do
      expect(page).to have_selector(:link_or_button, "Edit item")
    end

    scenario 'after the admin clicks on edit, they should be redirected' do
      click_on "Edit item", match: :first

      expect(page).to have_current_path(edit_item_path(item))
    end

    scenario "the admin updates the item title" do
      click_on "Edit item", match: :first
      fill_in "item[title]", with: "new pants"
      click_on "Update"

      expect(page).to have_content("You have successfully updated the item")
      expect(item.title).to eq("new pants")
    end

  end
end
