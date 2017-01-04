FactoryGirl.define do
  factory :item do
    title "MyString"
    description "MyText"
    price_in_cents 1
    image_url "MyText"
    references ""
  end
end
