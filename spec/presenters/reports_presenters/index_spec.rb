require 'rails_helper'

RSpec.describe ReportsPresenters::Index do
  let(:search_coupon_name)  { 'Testing' }
  let(:sales_to)            { nil }
  let(:sales_from)          { 2.days.ago }
  let(:coupons_page)        { 1 }
  let(:sales_page)          { nil }

  let(:params) do
    {
      coupon_name: search_coupon_name,
      sales_to: sales_to,
      sales_from: sales_from,
      coupons_page: coupons_page,
      sales_page: sales_page
    }
  end

  subject(:instance) { described_class.new(params) }

  its(:coupon_name) { is_expected.to eq search_coupon_name }
  its(:sales_to) { is_expected.to eq sales_to }
  its(:sales_from) { is_expected.to eq sales_from }
  its(:coupons_page) { is_expected.to eq coupons_page }
  its(:sales_page) { is_expected.to eq sales_page }

  describe '#coupons' do
    let(:coupon_name) { search_coupon_name}

    let!(:coupon1) { create(:coupon, name: coupon_name) }
    let!(:coupon2) { create(:coupon) }

    context 'with search by name' do
      subject { instance.coupons }

      it { is_expected.to eq([coupon1]) }
    end

    context 'without search by name' do
      let(:search_coupon_name) { nil }

      let(:coupon_name) { 'qwerty' }

      subject { instance.coupons }

      it { is_expected.to eq([coupon1, coupon2]) }
    end
  end

  describe '#all_coupon_names' do
    let!(:coupon1) { create(:coupon) }
    let!(:coupon2) { create(:coupon) }

    subject { instance.all_coupon_names }

    it { is_expected.to eq([coupon1.name, coupon2.name]) }
  end

  describe '#payment_ids' do
    let!(:payment1) { create(:payment, :completed, completed_at: 3.days.ago) }
    let!(:payment2) { create(:payment, :completed, completed_at: Date.current) }
    let!(:payment3) { create(:payment, :completed, completed_at: 3.days.from_now) }

    subject { instance.payment_ids }

    it { is_expected.to match_array([payment2.id, payment3.id]) }
  end

  describe '#sales_by_product' do

    let!(:order) { create(:order) }
    let!(:product) { create(:product) }
    let!(:order_item) { create(:order_item, order: order, state: 'sold', source: product) }
    let!(:payment) { create(:payment, :completed, order: order, completed_at: Date.current) }

    subject(:sales_by_product) { instance.sales_by_product }

    it { is_expected.to match_array([product]) }

    context 'extra attributes for collection' do
      subject { sales_by_product.first }

      its(:count) { is_expected.to eq 1 }
      its(:revenue) { is_expected.to eq order_item.price * order_item.quantity }
    end
  end
end
