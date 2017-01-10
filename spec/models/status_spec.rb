require 'rails_helper'

describe Status do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'associations' do
    it { is_expected.to have_many(:orders) }
  end

  it "count_of_orders method returns the # of orders with that status" do
    customer = create(:customer)
    status = create(:status, name: "paid")
    create_list(:order, 3, status: status)

    expect(status.count_of_orders).to eql(3)
  end
end
