require 'rails_helper'

feature 'the admin fails to update a item' do
  context 'when the admin visits admin/items' do
    let!(:admin) { logged_in_as_current_admin }
    let(:item) { Item.first }

    before do
      create(:category_with_items)
      visit items_path(admin)
      click_on_edit
    end

    scenario "the admin should see update failed message after failng to update the item" do
      failed_item_update

      expect(page).to have_content("You failed to update the item.")
    end

    scenario "after failing to update an item, the admin to should be routed back to the edit page" do
      failed_item_update

      expect(page).to have_current_path(item_path(item))
    end

    scenario "the admin fails to update the item title" do
      fill_in "item[title]", with: ""
      click_on "Update"

      expect(item.title).to_not be_empty
    end

    scenario "the admin fails to update the item description" do
      fill_in "item[description]", with: ""
      click_on "Update"

      expect(item.description).to_not be_empty
    end

    scenario "the admin fails to update the item image url" do
      fill_in "item[image_url]", with: ""
      click_on "Update"

      expect(item.image_url).to_not be_empty
    end

  end

  def click_on_edit
    click_on "Edit item", match: :first
  end

  def failed_item_update
    fill_in "item[title]", with: ""
    click_on "Update"
  end
end
