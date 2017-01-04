require 'rails_helper'

RSpec.describe Category do
  context 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:price_in_cents)}
    it {should validate_presence_of(:image_url)}
    it {should validate_presence_of(:category_id)}
    it {should validate_uniqueness_of(:title)}
    it {should validate_uniqueness_of(:image_url)}
  end

  context 'associations' do
    it {should belong_to(:category)}
  end
end
