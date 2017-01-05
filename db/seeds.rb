images = ['https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/MaryRose-wooden_spoon1.JPG/1280px-MaryRose-wooden_spoon1.JPG',
          'http://www.publicdomainpictures.net/pictures/50000/nahled/houten-kunstwerken-011.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Bough_bike_Sporty.jpg/913px-Bough_bike_Sporty.jpg']

3.times do
  category = Category.create!(name: Faker::Commerce.department)
  9.times do
    category.items.create!( title: Faker::Commerce.product_name,
                            description: Faker::Hipster.sentence,
                            price_in_cents: Faker::Number.number(4),
                            image_url: images[rand(3)])
  end
end
