require 'rails_helper'

describe "When viewing all items" do
  let!(:pants) { create(:item, title: "Rustic Wooden Pants", price_in_cents: 11_11, retired: true) }
  let!(:computer) { create(:item, title: "Synergistic Silk Computer", price_in_cents: 70_80) }

  # before_action { visit items_path }

  scenario "retired items are visible" do
    skip
    expect(page).to have_content("Rustic Wooden Pants")
  end

  scenario "retired items have disabled button" do
    skip
    within("item_#{pants.id}") do
      expect(page).not_to have_selector(:link_or_button, "Add to cart")
      expect(page).to have_selector(:link_or_button, "Item not available")
    end
  end
end
