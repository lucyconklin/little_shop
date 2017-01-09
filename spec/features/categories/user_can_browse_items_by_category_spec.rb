require 'rails_helper'

feature "when the user is browsing items by category" do
  let(:category_1) { create(:category_with_items) }
  let(:category_2) { create(:category_with_items) }
  let(:item_1) { category_1.items.first }
  let(:item_2) { category_1.items.last }
  let(:item_3) { category_2.items.first }
  let(:item_4) { category_2.items.last }

  before { visit category_path(category_1) }

  scenario "the user should see all items assigned to that category" do
    expect(page).to have_current_path "/#{category_1.slug}"
    expect(page).to have_content item_1.title
    expect(page).to have_content item_2.title
    expect(page).not_to have_content item_3.title
    expect(page).not_to have_content item_4.title
  end
end
