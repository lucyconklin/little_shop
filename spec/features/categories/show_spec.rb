require 'rails_helper'

describe "Browsing Items by category" do
  scenario "see all items assigned to that category" do
    category_1, category_2 = create_list(:category, 2)
    item_1, item_2, item_3, item_4 = create_list(:item, 4)
    category_1.items = [item_1, item_2]
    category_2.items = [item_3, item_4]

    visit category_path(category_1)

    expect(page).to have_current_path "/#{category_1.name}"
    expect(page).to have_content item_1.title
    expect(page).to have_content item_2.title
    expect(page).not_to have_content item_3.title
    expect(page).not_to have_content item_4.title
  end
end
