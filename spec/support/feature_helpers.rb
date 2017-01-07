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

  def add_one_item_to_cart(item)
    within "#item_#{item.id}" do
      click_on "Add to cart"
    end
  end

  def click_on_decrease(item)
    within("#item_#{item.id}") do
      click_on "-"
    end
  end
  
  def click_on_remove(item)
    within("#item_#{@item_1.id}") do
      click_on "Remove"
    end
  end

end
