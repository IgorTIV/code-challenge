require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }

  it 'validates amount by format' do
    valid_coupon = build(:coupon, amount: '100.01')
    expect(valid_coupon).to be_valid

    invalid_coupon = build(:coupon, amount: '100.011')
    expect(invalid_coupon).to be_invalid
  end

  it { is_expected.to have_many(:order_items) }
  it { is_expected.to have_many(:orders).through(:order_items) }
  it { is_expected.to have_many(:users).through(:orders) }

  describe '.by_name' do
    let(:coupon1) { create(:coupon, name: 'One') }
    let(:coupon2) { create(:coupon, name: 'Freebie') }

    subject { described_class.by_name('Freebie') }

    it { is_expected.to eq([coupon2]) }
  end
end
