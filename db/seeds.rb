puts "This will take a little time... \n"
puts "Deleting all existing items from your database... \n"
OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
Category.destroy_all
Status.destroy_all
Customer.destroy_all

puts "Making some new items for your database... \n\n" 
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

all_items = Item.all

customers.each do |customer|
  number_between_1_and_5 = rand(5) + 1
  number_between_1_and_9 = rand(9) + 1
  items_in_order = all_items.sample(number_between_1_and_5)
  2.times { items_in_order << items_in_order.sample(2) }
  items_in_order.flatten!

  number_between_1_and_9.times do
    customer.orders << FactoryGirl.create(:order, items: items_in_order)
  end
end

puts "Here is a sample customer, just for you, so you can log in right away. \n"
customer = Customer.find_by(email: "customer@example.com")
unless customer
  customer = Customer.new(first_name: "Joan",
                          last_name: "Doe",
                         email: "customer@example.com",
                         password: "boom")
  customer.save!
end
puts "Sample customer: \n" + \
"  email: #{customer.email} \n" + \
"  password: boom"

