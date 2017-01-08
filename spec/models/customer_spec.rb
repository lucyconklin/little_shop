require 'rails_helper'

describe Customer do
  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password_digest) }
  end

  context "associations" do
    it { is_expected.to have_many(:orders) }
  end

  scenario 'is valid when all fields are present' do
    customer = Customer.create(first_name: "Jane",
                                last_name: "Doe",
                                email: "jane@jane.com",
                                password: "boom")

    expect(customer).to be_valid
  end
end
