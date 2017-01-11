require 'rails_helper'

RSpec.describe Category do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  context 'associations' do
    it { is_expected.to have_many(:items) }
  end

  scenario 'is valid with a name' do
    category = Category.create(name: "Kitchen Things")

    expect(category).to be_valid
  end

  it "sort_by_name returns a sorted array of categories" do
    create(:category, name: "Kitchen Things")
    create(:category, name: "Furniture")
    create(:category, name: "Garden Things")
    create(:category, name: "Jewelry")

    categories = Category.all.sort_by_name
    expect(categories[0].name).to eql("Furniture")
    expect(categories[1].name).to eql("Garden Things")
    expect(categories[2].name).to eql("Jewelry")
    expect(categories[3].name).to eql("Kitchen Things")
  end
end
