OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
Category.destroy_all
Status.destroy_all
Customer.destroy_all

3.times do
  category = Category.create!(name: Faker::Commerce.department)
  9.times do
    category.items << FactoryGirl.create(:item)
  end
end

status_names = ["ordered", "paid", "cancelled", "completed"]
status_names.each do |name|
  Status.create(name: name)
end

FactoryGirl.create_list(:customer, 111)

customers = Customer.all
items = Item.all
statuses = Status.all
number_between_one_and_five = rand(5) + 1

customers.each do |customer|
  number_between_one_and_five.times do
    customer.orders << FactoryGirl.create(:order)
  end
end
