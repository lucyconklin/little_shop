require 'rails_helper'

describe Admin do
  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password_digest) }
  end

  scenario 'is valid when all fields are present' do
    admin = Admin.create(first_name: "Jane",
                         last_name: "Doe",
                         email: "jane@jane.com",
                         password: "boom")

    expect(admin).to be_valid
  end
end
