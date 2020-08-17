require 'rails_helper'

RSpec.describe Tax, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:rate) }
  it { is_expected.to validate_numericality_of(:rate).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(1) }

  it 'validates rate by format' do
    valid_tax = build(:tax, rate: 0.123)
    expect(valid_tax).to be_valid

    invalid_tax = build(:tax, rate: 0.1234)
    expect(invalid_tax).to be_invalid
  end

  it { is_expected.to have_many(:order_items) }
end
