FactoryGirl.define do

  factory :status do
    name { %w(paid cancelled completed ordered).sample }
  end

  factory :order do
    total_price_in_cents 0
    customer { Customer.all.sample(1).first }
    status { Status.all.sample(1).first }
    items { FactoryGirl.create_list(:item, 5) }
  end

  factory :all_new_order, class: Order do
    total_price_in_cents 0
    customer
    status
    items { FactoryGirl.create_list(:item, 5) }
  end

  factory :customer do
    first_name            { Faker::Pokemon.name }
    last_name             { Faker::StarWars.planet.split.join("-") }
    email                 { first_name + "_of_" + last_name + "_" + Faker::Number.hexadecimal(4) + "@example.com" }
    password              { "boom" }
    password_confirmation { "boom" }
  end

  images = [
    "https://c3.staticflickr.com/1/491/32126903786_1f8721dbd3_z.jpg",
    "https://c5.staticflickr.com/1/545/32126904116_7a10e1908d_z.jpg",
    "https://c5.staticflickr.com/1/741/31323658124_41991bd758_z.jpg",
    "https://c7.staticflickr.com/1/507/31323657934_5ca4821c98_z.jpg",
    "https://c8.staticflickr.com/1/706/31354735023_1c24fcdec9_z.jpg",
    "https://c1.staticflickr.com/1/309/31323658224_a951982f5e_z.jpg",
    "https://c8.staticflickr.com/1/765/31354735103_d463a30223_z.jpg",
    "https://c7.staticflickr.com/1/424/31323657974_6f6231e2c2_z.jpg",
    "https://c4.staticflickr.com/1/692/31354735243_162945a476_z.jpg",
    "https://c3.staticflickr.com/1/439/32126903946_1ee92bbe42_z.jpg",
    "https://c3.staticflickr.com/1/662/31323658434_1d8f1959d3_z.jpg"
  ]

  factory :item do
    sequence(:title) { |n| Faker::Commerce.product_name + " #{n}" }
    description { Faker::Hipster.sentence }
    price_in_cents { Faker::Number.number(4) }
    image_url { images.sample }
    category
  end

  factory :category do
    sequence(:name) { |n| Faker::Commerce.department + " #{n}" }

    factory :category_with_items do
      transient do
        items_count 5
      end

      after(:create) do |category, evaluator|
        create_list(:item, evaluator.items_count, category: category)
      end
    end
  end

  factory :admin do
    first_name            "Jane"
    last_name             "Boss"
    email                 "jane@admin.com"
    password              "admin_boom"
    password_confirmation "admin_boom"
  end
end
