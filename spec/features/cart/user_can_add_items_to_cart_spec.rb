require 'rails_helper'

feature "When a customer visits the items index and adds items to their cart" do

  let!(:pants) { create(:item, title: "Rustic Wooden Pants") }
  let!(:computer) { create(:item, title: "Synergistic Silk Computer") }

  before { visit items_path }

  scenario "the user should see a add to cart button or link" do
    expect(page).to have_selector(:link_or_button, "Add to cart")
  end

  scenario "the cart counter says 1 after adding the first item" do
    within "#item_#{pants.id}" do
      click_on "Add to cart"
    end

    expect(page).to have_content("You have added 1 #{pants.title} to your cart.")
    expect(page).to have_css(".cart_counter", text: "1")
  end

  scenario "the cart counter says 2 after adding another one of the first item" do
    2.times do
      within "#item_#{computer.id}" do
        click_on "Add to cart"
      end
    end

    expect(page).to have_css(".cart_counter", text: "2")
  end

  scenario "the cart counter says 3 after adding one of the second item" do
    2.times do
      within "#item_#{computer.id}" do
        click_on "Add to cart"
      end
    end
    within "#item_#{pants.id}" do
      click_on "Add to cart"
    end

    expect(page).to have_css(".cart_counter", text: "3")
  end
end

feature "When a customer visits the items detail page and adds that item to their cart" do
  let!(:shoes) { create(:item, title: "Four dollar shoes") }
  before { visit item_path(shoes) }

  scenario "the user should see an add to cart button" do
    expect(page).to have_selector(:link_or_button, "Add to cart")
  end

  scenario "the cart counter starts at one when nothing has been previously added to the cart" do
    click_on "Add to cart"

    expect(page).to have_css(".cart_counter", text: "1")
  end

  scenario "the cart counter increments by one when items have already been added to the cart" do
    add_three_items_to_cart
    visit item_path(shoes)
    expect(page).to have_css(".cart_counter", text: "3")

    click_on "Add to cart"

    expect(page).to have_css(".cart_counter", text: "4")
  end
end
