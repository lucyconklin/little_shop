require 'rails_helper'

feature "When a customer visits the items index and adds items to their cart" do
  before(:all) do
   create_list(:item, 2)
    visit items_path
  end

  scenario "the user should see a add to cart button or link" do
    expect(page).to have_selector(:link_or_button,"Add Item")
  end

  scenario "the cart counter says 1 after adding the first item" do
    click_on("Add Item", match: :first)

    expect(page).to have_content("1")
  end

  scenario "the cart counter says 2 after adding another one of the first item" do
    click_on("Add Item", match: :first)
    expect(page).to have_content("1")
    click_on("Add Item", match: :first)

    expect(page).to have_content("2")
  end

  scenario "the cart counter says 3 after adding one of the second item" do
    click_on("Add Item", match: :first)
    expect(page).to have_content("1")
    click_on("Add Item", match: :first)
    expect(page).to have_content("2")
    click_on("Add Item", match: :second)

    expect(page).to have_content("3")
  end

end
