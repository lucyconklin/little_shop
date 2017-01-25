require 'rails_helper'

describe Status do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'associations' do
    it { is_expected.to have_many(:orders) }
  end

  it "count_of_orders method returns the # of orders with that status" do
    create(:customer)
    status = create(:status, name: "paid")
    create_list(:order, 3, status: status)

    expect(status.count_of_orders).to eql(3)
  end

  it "sort_by_name returns a sorted array of statuses" do
    create(:status, name: "paid")
    create(:status, name: "cancelled")
    create(:status, name: "ordered")
    create(:status, name: "completed")

    statuses = Status.all.sort_by_name
    expect(statuses[0].name).to eql("cancelled")
    expect(statuses[1].name).to eql("completed")
    expect(statuses[2].name).to eql("ordered")
    expect(statuses[3].name).to eql("paid")
  end
end
