require 'rails_helper'

feature 'When a visitor has items in their cart' do

  let!(:item_1) { create(:item, title: "Rustic Wooden Pants", price_in_cents: 11_11) }
  let!(:item_2) { create(:item, title: "Synergistic Silk Computer", price_in_cents: 70_80) }

  before  do
    visit items_path
    add_one_item_to_cart(item_1)
    add_one_item_to_cart(item_2)
    visit cart_path
  end

  scenario "the user has two items in their cart" do
    expect(page).to have_content("#{item_1.description}")
    expect(page).to have_content("#{item_2.description}")
  end

  scenario "the user should not see an option to checkout" do
    expect(page).to_not have_button("Checkout")
  end

  scenario "the user should see a link or button to login or create an account" do
    visit cart_path

    expect(page).to have_selector(:link_or_button, "Log in")
    expect(page).to have_selector(:link_or_button, "Create Account to Checkout")
  end

  scenario "after the user creates an account, the should be redirected to their cart" do
    click_on "Create Account to Checkout"
    create_valid_account
    expect(page).to have_content("Successfully logged in!")
    expect(page).to have_current_path(cart_path)
  end

  scenario "the user should then see the items that were originally in their cart" do
    click_on "Create Account to Checkout"
    create_valid_account

    expect(page).to have_current_path(cart_path)
    expect(page).to have_content("#{item_1.description}")
    expect(page).to have_content("#{item_2.description}")
  end

  scenario "the user should then see a logout button or link" do
    click_on "Create Account to Checkout"
    create_valid_account

    expect(page).to have_selector(:link_or_button, "Log out")
  end
end
