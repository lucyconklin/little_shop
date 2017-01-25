require 'rails_helper'

describe "Viewing all items" do
  let!(:item_1) { create(:item) }
  let!(:item_2) { create(:item) }
  let!(:item_3) { create(:item, retired: true) }

  scenario "shows all items" do
    visit items_path

    expect(page).to have_current_path items_path
    expect(page).to have_content item_1.title
    expect(page).to have_content item_2.title
    expect(page).to have_content item_3.title
  end

  scenario "retired items have disabled button" do
    visit items_path

    within("#item_#{item_3.id}") do
      expect(page).not_to have_selector(:link_or_button, "Add to cart")
      expect(page).to have_content("Item not available")
    end
  end
end
