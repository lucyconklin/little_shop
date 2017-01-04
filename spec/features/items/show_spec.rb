require 'rails_helper'

describe "Viewing one item" do
  it "displays the information for that item" do
    create_list(:item, 2)
    item = create(:item)
    visit items_path

    within "#item_#{item.id}" do
      click_on item.title
    end

    expect(page).to have_current_path item_path(item)
    expect(page).to have_content item.title
    expect(page).to have_content item.description
    expect(page).to have_content item.price_in_dollars
    expect(page).to have_content item.category_name
  end
end
