require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:sku) }

  it { is_expected.to validate_presence_of(:msrp) }
  it { is_expected.to validate_numericality_of(:msrp).is_greater_than_or_equal_to(0) }

  it { is_expected.to validate_presence_of(:cost) }
  it { is_expected.to validate_numericality_of(:cost).is_greater_than_or_equal_to(0) }

  it 'validates cost by format' do
    valid_coupon = build(:product, cost: '100.01')
    expect(valid_coupon).to be_valid

    invalid_coupon = build(:product, cost: '100.011')
    expect(invalid_coupon).to be_invalid
  end

  it 'validates msrp by format' do
    valid_product = build(:product, msrp: '100.01')
    expect(valid_product).to be_valid

    invalid_product = build(:product, msrp: '100.011')
    expect(invalid_product).to be_invalid
  end

  it { is_expected.to have_many(:order_items) }
end
