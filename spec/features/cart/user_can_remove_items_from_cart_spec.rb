require 'rails_helper'

feature "A user can remove an item from the cart" do
  before do
    visit cart_path
  end

  context "when the cart is empty" do
    it "a user cannot remove anything from the cart" do
      expect(current_path).to eq('/cart')
      expect(page).to have_content("Your cart is currently empty.")
      expect(page).not_to have_content("Remove")
    end
  end

  context "When a cart has only one an item in it" do
    it "a user can remove that one item" do
      item = create(:item)
      add_one_item_to_cart(item)

      visit cart_path

      expect(page).to have_content("Remove")

      click_on "Remove"

      expect(page).not_to have_content(item.description)
      expect(current_path).to eq("/cart")
      expect(page).not_to have_content(:link_or_button, "Remove")
      expect(page).to have_content("Succesfully removed #{item.title} from your cart.")
      expect(page).to have_css(".alert", text: item.title)
      expect(page).to have_content("Your cart is currently empty.")
      expect(page).to have_content(:link, item.title)
    end
  end

  context "When a cart has two items in it" do
    it "a user can remove one item and other item persists" do
      item_1, item_2 = create_list(:item, 2)
      add_one_item_to_cart(item_1)
      add_one_item_to_cart(item_2)

      visit cart_path

      within("#item_#{item_1.id}") do
        click_on "Remove"
      end

      expect(page).not_to have_content(item_1.description)
      expect(page).to have_content(item_2.description)
      expect(page).to have_content(:link, item_1.title)
    end
  end

  context "When a cart has 2 of each item" do
    it "a user can remove one of an item" do
      item_1, item_2 = create_list(:item, 2)
      add_one_item_to_cart(item_1)
      add_one_item_to_cart(item_1)
      add_one_item_to_cart(item_2)
      add_one_item_to_cart(item_2)

      visit cart_path

      within("#item_#{item_1.id}") do
        click_on "Remove"
      end

      expect(page).to have_content("2 x $#{item_2.price_in_dollars}")
      expect(page).to have_content("1 x $#{item_1.price_in_dollars}")
    end
  end
end
