require 'rails_helper'

feature "When a customer visits the items index and wants to view their cart" do

  let!(:pants) { create(:item, title: "Rustic Wooden Pants") }
  let!(:computer) { create(:item, title: "Synergistic Silk Computer") }

  before { visit items_path }

  scenario 'the user should see a view cart button or link' do
    expect(page).to have_selector(:link_or_button, "View cart")
  end

  scenario 'the user clicks on view cart' do
    item = add_one_item_to_cart
    click_on "View cart"
    expect(page).to have_current_path(cart_path(cart))
  end

  scenario 'the user should see a small image of the item' do
    expect(page).to have_current_path("/cart")
    expect(page).to have_css("img[src*='image_name.png']")
  end

  scenario 'the user should see the title of the item' do
    expect(page).to have_current_path("/cart")
    expect(page).to have_content(Item.first.title)
  end

  scenario 'the user should see the description of the item' do
    expect(page).to have_current_path("/cart")
    expect(page).to have_content(Item.first.description)
  end

  scenario 'the user should see the price of the item' do
    expect(page).to have_current_path("/cart")
    expect(page).to have_content(Item.first.price)
  end

  scenario 'the user should see the total price of the cart' do
    expect(page).to have_current_path("/cart")
    expect(page).to have_content(cart.total_price)
  end

end
