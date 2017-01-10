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

    scenario 'after clicking on edit the admin should be redirected' do
      click_on_edit

      expect(page).to have_current_path("/admin/items/#{item.id}/edit")
    end

    scenario "the admin should see a successfully updated item message after updating the item" do
      update_item

      expect(page).to have_content("You have successfully updated the item")
    end

    scenario "after updating an item, the admin to should be routed to the item show page" do
      update_item

      expect(page).to have_current_path(item_path(item))
    end

    scenario "the admin updates the item title" do
      click_on_edit
      fill_in "item[title]", with: "new pants"
      click_on "Update"

      expect(item.title).to eq("new pants")
    end

    scenario "the admin updates the item description" do
      new_description = "Genuine lumberjack pants. Look like you do work, without actually doing it."
      click_on_edit
      fill_in "item[description]", with: "#{new_description}"
      click_on "Update"

      expect(item.description).to eq(new_description)
    end

    scenario "the admin updates the item image url" do
      new_image_url = "http://starecat.com/content/wp-content/uploads/i-am-so-glad-i-dont-have-to-actually-hunt-i-have-no-clue-where-gluten-free-tacos-live-bearded-man.jpg"
      click_on_edit
      fill_in "item[image_url]", with: new_image_url
      click_on "Update"

      expect(item.image_url).to eq(new_image_url)
    end

    scenario "the admin updates the item retired field" do
      click_on_edit
      select 'True', from:"item_retired"
      click_on "Update"

      expect(item.retired).to be true
    end

  end

  def click_on_edit
    click_on "Edit item", match: :first
  end

  def update_item
    click_on_edit
    fill_in "item[title]", with: "new pants"
    click_on "Update"
  end
end
