require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { is_expected.to validate_presence_of(:order_id) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:payment_type) }

  it { is_expected.to validate_presence_of(:amount) }

  it 'validates amount by format' do
    valid_coupon = create(:payment, amount: '100.01')
    expect(valid_coupon).to be_valid

    invalid_coupon = build(:payment, amount: '100.011')
    expect(invalid_coupon).to be_invalid
  end

  it { is_expected.to belong_to(:order) }

  describe '.completed' do
    let(:payment1) { create(:payment, state: 'completed') }
    let(:payment2) { create(:payment, state: 'completed') }
    let(:payment3) { create(:payment, state: 'refunded') }

    subject { described_class.completed }

    it { is_expected.to match_array([payment1, payment2]) }
  end

  describe '.from_date' do
    let(:payment1) { create(:payment, completed_at: 3.days.ago) }
    let(:payment2) { create(:payment, completed_at: Date.current) }
    let(:payment3) { create(:payment, completed_at: 3.days.from_now) }

    subject { described_class.from_date(1.days.ago) }

    it { is_expected.to match_array([payment2, payment3]) }
  end

  describe '.to_date' do
    let(:payment1) { create(:payment, completed_at: 3.days.ago) }
    let(:payment2) { create(:payment, completed_at: Date.current) }
    let(:payment3) { create(:payment, completed_at: 3.days.from_now) }

    subject { described_class.to_date(1.days.ago) }

    it { is_expected.to match_array([payment1]) }
  end
end
