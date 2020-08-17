require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:state) }

  it { is_expected.to validate_presence_of(:total) }

  it 'validates total by format' do
    address = create(:address)

    valid_order = build(:order, address: address, user: address.user, total: 100.01)
    expect(valid_order).to be_valid

    invalid_order = build(:order, address: address, user: address.user, total: 100.011)
    expect(invalid_order).to be_invalid
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:address) }

  it { is_expected.to have_many(:order_items) }
  it { is_expected.to have_many(:payments) }

  describe '.by_number' do
    let(:order1) { create(:order, number: 123) }
    let(:order2) { create(:order, number: 555) }

    subject { described_class.by_number(123) }

    it { is_expected.to eq([order1]) }
  end

  describe '#to_param' do
    let(:order) { build(:order) }

    subject { order.to_param }

    it { is_expected.to eq(order.number) }
  end

  describe '#cancelled?' do
    subject { build(:order, state: 'canceled') }

    it { is_expected.to be_cancelled }
  end
end
