module FeatureHelpers

  def add_three_items_to_cart
    item = create(:item)
    visit items_path
    3.times do
      within "#item_#{item.id}" do
        click_on "Add to cart"
      end
    end
  end

end