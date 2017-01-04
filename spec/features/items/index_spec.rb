require 'rails_helper'

describe "Viewing all items" do
  scenario "shows all items" do
    item_1, item_2, item_3 = create_list(:item, 3)
    visit items_path

    expect(page).to have_current_path "/items"
    expect(page).to have_content item_1.title
    expect(page).to have_content item_2.title
    expect(page).to have_content item_3.title
  end
end

