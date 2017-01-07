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

  context "When a cart has only one item in it" do
    let!(:item) { create(:item) }

    before do
      visit items_path
      add_one_item_to_cart(item)
      visit cart_path
    end

    it "a user can remove that one item" do
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
    before do
      @item_1, @item_2 = create_list(:item, 2)
      2.times do
        visit items_path
        add_one_item_to_cart(@item_1)
        add_one_item_to_cart(@item_2)
      end
      visit cart_path
    end

    it "a user can remove one item and other item persists" do
      click_on_remove(@item_1)

      expect(page).not_to have_content(@item_1.description)
      expect(page).to have_content(@item_2.description)
      expect(page).to have_content(:link, @item_2.title)
    end
  end

  context "When a cart has 2 of each item" do
    before do
      @item_1, @item_2 = create_list(:item, 2)
      2.times do
        visit items_path
        add_one_item_to_cart(@item_1)
        add_one_item_to_cart(@item_2)
      end
      visit cart_path
    end

    it "a user can remove one of an item" do
      click_on_remove(@item_1)

      expect(page).to have_content("2 x $#{@item_2.price_in_dollars}")
    end

    it 'the user should see a decrease button or link' do
      within("#item_#{@item_1.id}") do
        expect(page).to have_content(:link_or_button, "-")
      end
    end

    it 'user can decrease the quantity of items' do
      expect(page).to have_content("2 x $#{@item_1.price_in_dollars}")
      click_on_decrease(@item_1)

      expect(page).to have_content("1 x $#{@item_1.price_in_dollars}")
    end

    it "the user should see a message when an item has been removed from the cart" do
      click_on_remove(@item_1)
      message = "Succesfully removed #{@item_1.title} from your cart."

      expect(page).to have_content(message)
    end

    it 'the user sees a message when the item quantity is decreased to zero' do
      click_on_decrease(@item_1)
      click_on_decrease(@item_1)

      message = "Succesfully removed #{@item_1.title} from your cart."

      expect(page).to have_content(message)
    end
  end
end
