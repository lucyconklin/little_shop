require 'rails_helper'

describe Item do
  describe "validations" do
    context 'validations' do
      it {should validate_presence_of(:description)}
      it {should validate_presence_of(:title)}
      it {should validate_presence_of(:price_in_cents)}
      it {should validate_presence_of(:image_url)}
      it {should validate_uniqueness_of(:title)}
      it {should validate_uniqueness_of(:image_url)}
    end
  end

  describe "associations" do
    context 'belongs to a category' do
      it {should belong_to(:category)}
    end
  end
end
