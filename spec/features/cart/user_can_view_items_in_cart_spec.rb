require 'rails_helper'

feature "When a customer visits the home page and wants to view their cart" do
  let!(:pants) { create(:item, title: "Rustic Wooden Pants", price_in_cents: 11_11) }
  let!(:computer) { create(:item, title: "Synergistic Silk Computer", price_in_cents: 22_22) }
  let!(:spoon) { create(:item, title: "Four Dollar Wooden Spoon", price_in_cents: 33_33) }

  before do
    visit items_path
    2.times do
      add_one_item_to_cart(pants)
    end
    add_one_item_to_cart(computer)
    add_one_item_to_cart(spoon)
    visit root_path
    click_on "View cart"
  end

  scenario "clicking on view cart takes them to the cart page" do
    expect(page).to have_current_path("/cart")
  end

  scenario "the user sees the title of the item" do
    expect(page).to have_content pants.title
    expect(page).to have_content computer.title
    expect(page).to have_content spoon.title
  end

  scenario "the user sees the description of the item" do
    expect(page).to have_content pants.description
    expect(page).to have_content computer.description
    expect(page).to have_content spoon.description
  end

  scenario "the user sees the price of the item" do
    expect(page).to have_content pants.price_in_dollars
    expect(page).to have_content computer.price_in_dollars
    expect(page).to have_content spoon.price_in_dollars
  end

  scenario "the user sees the quantity for each item" do
    expect(page).to have_content "2 x $11.11"
    expect(page).to have_content "1 x $22.22"
    expect(page).to have_content "1 x $33.33"
  end

  scenario "the user sees the total price of the cart" do
    expect(page).to have_content "$77.77"
  end
end
