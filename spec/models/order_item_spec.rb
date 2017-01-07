require 'rails_helper'

describe OrderItem do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:item_quantity) }
    it { is_expected.to validate_presence_of(:item_price_in_cents) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:item) }
  end
end
