require 'rails_helper'

feature "When a customer visits /cart" do
  before(:all) do
    create_list(:item, 2)
    visit items_path
    click_on("Add To Cart")
    visit cart_path
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
    expect(page).to have_content(Cart.total_price)
  end
end
