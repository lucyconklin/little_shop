OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
Category.destroy_all
Status.destroy_all
Customer.destroy_all

FactoryGirl.create_list(:category, 7)
categories = Category.all
number_from_20_to_40 = rand(20) + 20

categories.each do |category|
  category.items << FactoryGirl.create_list(:item, number_from_20_to_40, category: category)
end

status_names = ["ordered", "paid", "cancelled", "completed"]
status_names.each do |name|
  Status.create(name: name)
end

FactoryGirl.create_list(:customer, 111)
customers = Customer.all

items = Item.all

customers.each do |customer|
  number_between_1_and_5 = rand(5) + 1
  number_between_1_and_9 = rand(9) + 1

  number_between_1_and_9.times do
    customer.orders << FactoryGirl.create(:order, items: items.sample(number_between_1_and_5))
  end
end
