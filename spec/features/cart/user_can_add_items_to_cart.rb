require 'rails_helper'

RSpec.feature "When a customer visits the items index and adds items to their cart", type: :feature do
  before(:all) do
    item1, item2 = create_list(:item, 2)
  end

  scenario "the cart counter says 1 after adding the first item" do
    visit items_path
    click_on ("Add Item", match: :first)

    expect(page).to have_content("1")
  end

  scenario "the cart counter says 2 after adding another one of the first item" do
    visit items_path
    click_on ("Add Item", match: :first)
    expect(page).to have_content("1")
    click_on ("Add Item", match: :first)

    expect(page).to have_content("2")
  end

  scenario "the cart counter says 3 after adding one of the second item" do
    visit items_path
    click_on ("Add Item", match: :first)
    expect(page).to have_content("1")
    click_on ("Add Item", match: :first)
    expect(page).to have_content("2")
    click_on ("Add Item", match: :second)

    expect(page).to have_content("3")
  end

end
