require 'rails_helper'

describe Order do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:total_price_in_cents) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:order_items) }
    it { is_expected.to have_many(:items).through(:order_items) }
    it { is_expected.to belong_to(:status) }
    it { is_expected.to belong_to(:customer) }
  end
end
