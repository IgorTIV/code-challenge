require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe 'GET #index' do
    let(:presenter) do
      double(
        coupons: 'coupons list',
        all_coupon_names: 'all names of coupons',
        sales_by_product: 'sales_by_product'
      )
    end

    before do
      expect(ReportsPresenters::Index).to receive(:new)
        .with(ActionController::Parameters.new({ sales_page: '2' }).permit!)
        .and_return(presenter)

      get :index, params: { sales_page: '2' }
    end

    context 'response' do
      subject { response }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template('index') }
    end

    context 'assigns' do
      subject { assigns }

      its([:coupons]) { is_expected.to eq presenter.coupons }
      its([:all_coupon_names]) { is_expected.to eq presenter.all_coupon_names }
      its([:sales_by_product]) { is_expected.to eq presenter.sales_by_product }
    end
  end
end
