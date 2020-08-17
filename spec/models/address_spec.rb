require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to validate_presence_of(:address1) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:user_id) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_many(:orders) }

  it 'validates zipcode by format' do
    user = create(:user)

    valid_address = build(:address, user: user, zipcode: '62250')
    expect(valid_address).to be_valid

    valid_address = build(:address, user: user, zipcode: '622')
    expect(valid_address).to be_invalid
  end

  context 'validation for uniqueness of user_id' do
    subject { create(:address) }

    it { is_expected.to validate_uniqueness_of(:user_id) }
  end
end
