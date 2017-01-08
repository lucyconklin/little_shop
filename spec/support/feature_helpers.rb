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
    within("#item_#{item.id}") do
      click_on "Remove"
    end
  end

  def login
    fill_in "email", with: "jane@jane.com"
    fill_in "password", with: "boom"
    within("form") do
      click_on "Log in"
    end
  end

  def create_valid_account
    fill_in "customer[first_name]", with: "John"
    fill_in "customer[last_name]", with: "Smith"
    fill_in "customer[email]", with: "john@john.com"
    fill_in "customer[password]", with: "boom"
    fill_in "customer[password_confirmation]", with: "boom"
    click_on "Create Account"
  end

  def invalid_account_creation
    fill_in "customer[first_name]", with: "Bill"
    fill_in "customer[last_name]", with: "Sparks"
    fill_in "customer[email]", with: "john@john.com"
    fill_in "customer[password]", with: "blue"
    click_on "Create Account"
  end

  def log_in_as_customer(customer = create(:customer))
    visit login_path
    fill_in "Email", with: customer.email
    fill_in "Password", with: "boom"
    within("form") do
      click_on "Log in"
    end
    customer
  end
end
