require 'rails_helper'

feature "When a customer visits the items index and adds items to their cart" do
  before do
    create(:item, title: "Rustic Wooden Pants")
    create(:item, title: "Synergistic Silk Computer")
    visit items_path
  end

  scenario "the user should see a add to cart button or link" do
    expect(page).to have_selector(:link_or_button,"Add to cart")
  end

  scenario "the cart counter says 1 after adding the first item" do
    click_on("Add to cart", match: :first)

    expect(page).to have_content("Rustic Wooden Pants")
    expect(page).to have_content("You have 1 item in your cart.")
    expect(Cart.count).to eq(1)
  end

  scenario "the cart counter says 2 after adding another one of the first item" do
    2.times do
      click_on("Add to cart", match: :first)
    end

    expect(page).to have_content("Rustic Wooden Pants")
    expect(page).to have_content("Synergistic Silk Computer")
    expect(page).to have_content("You have 2 items in your cart")
    expect(Cart.count).to eq(2)
  end

  scenario "the cart counter says 3 after adding one of the second item" do
    3.times do
      click_on("Add to cart", match: :first)
    end

    expect(page).to have_content("Rustic Wooden Pants")
    expect(page).to have_content("Synergistic Silk Computer")
    expect(page).to have_content("You have 3 items in your cart")
    expect(Cart.count).to eq(3)
  end
end
