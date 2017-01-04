FactoryGirl.define do
  factory :item do
    sequence(:title) { |n| Faker::Commerce.product_name + " #{n}" }

    description { Faker::Hipster.sentence }
    price_in_cents { Faker::Number.number(4) }
    image_url { Faker::Avatar.image }
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
end
