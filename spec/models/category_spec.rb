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
end
