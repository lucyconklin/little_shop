require 'rails_helper'

describe Item do
  context 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price_in_cents) }
    it { is_expected.to validate_presence_of(:image_url) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it "is false by default" do
      item = create(:item)
      expect(item.retired).to be_falsey
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:category) }
  end

  scenario 'is valid when all fields are present' do
    item = Item.create(title: "Wooden Spoons",
                       description: "These are hand carved.",
                       price_in_cents: "100",
                       image_url: "https://c1.staticflickr.com/1/138/379043173_3776319eec_z.jpg?zz=1")

    expect(item).to be_valid
  end

  describe "#price_in_dollars" do
    it "returns the price in dollars" do
      item = create(:item, price_in_cents: 12_34)

      expect(item.price_in_dollars).to eq 12.34
    end
  end

  describe "#category_name" do
    it "returns the category name" do
      category = create(:category, name: "Four Dollar Toast")
      item = create(:item, category: category)

      expect(item.category_name).to eq "Four Dollar Toast"
    end
  end
end
