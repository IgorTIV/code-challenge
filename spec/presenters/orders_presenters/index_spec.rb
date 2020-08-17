require 'rails_helper'

RSpec.describe OrdersPresenters::Index do
  let(:search_number) { 899 }
  let(:page)          { 1 }

  let(:params) do
    {
      number: search_number,
      page: page
    }
  end

  subject(:instance) { described_class.new(params) }

  its(:number) { is_expected.to eq search_number }
  its(:page)   { is_expected.to eq page }

  describe '#orders' do
    let(:order_number) { search_number }

    let!(:order1) { create(:order, number: order_number) }
    let!(:order2) { create(:order) }

    subject { instance.orders }

    context 'with search by number' do

      it { is_expected.to eq([order1]) }
    end

    context 'without search by number' do
      let(:search_number) { nil }

      let(:order_number)  { 1235 }

      it { is_expected.to eq([order1, order2]) }
    end

    context 'with pagination' do
      let(:order_number)  { 1235 }

      let(:search_number) { nil }
      let(:page)          { 3 }

      before { create_list(:order, 25) }

      its(:size) { is_expected.to eq 7 }
    end
  end
end
