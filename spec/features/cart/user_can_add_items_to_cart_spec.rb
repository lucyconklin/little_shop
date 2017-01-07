require 'rails_helper'

feature "When a customer visits the items index and adds items to their cart" do
  let!(:pants) { create(:item, title: "Rustic Wooden Pants", price_in_cents: 11_11) }
  let!(:computer) { create(:item, title: "Synergistic Silk Computer") }

  scenario "the user should see a add to cart button or link" do
    visit items_path
    expect(page).to have_selector(:link_or_button, "Add to cart")
  end

  scenario "the cart counter says 1 after adding the first item" do
    add_one_item_to_cart(pants)

    expect(page).to have_content("You have added 1 #{pants.title} to your cart.")
    expect(page).to have_css(".cart_counter", text: "1")
  end

  scenario "the cart counter says 2 after adding another one of the first item" do
    2.times do
      add_one_item_to_cart(pants)
    end

    expect(page).to have_css(".cart_counter", text: "2")
  end

  scenario "the cart counter says 3 after adding one of the second item" do
    2.times do
      add_one_item_to_cart(pants)
    end
    add_one_item_to_cart(computer)
    expect(page).to have_css(".cart_counter", text: "3")
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

  feature "when a customer visits the cart path" do
    before do
      2.times do
        add_one_item_to_cart(pants)
      end
      visit cart_path

    end

    it 'the user should see the button or link increase' do
      expect(page).to have_content(:link_or_button, "+")
    end

    context "when a cart already has one item in it" do
      scenario "the user should be able to click on increase and the quantity of the item goes up" do


        expect(page).to have_content("2 x $11.11")
        expect(page).to have_content("Subtotal: $22.22")

        click_on "+"

        expect(page).to have_current_path("/cart")
        expect(page).not_to have_content("$22.22")
        expect(page).to have_content("Subtotal: $33.33")
        expect(page).to have_content("3 x $11.11")
      end
    end
  end
end
