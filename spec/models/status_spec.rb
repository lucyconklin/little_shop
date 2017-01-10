require 'rails_helper'

describe Status do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'associations' do
    it { is_expected.to have_many(:orders) }
  end

  #need to test count_of_orders method
end
