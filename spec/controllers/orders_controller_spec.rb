require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET #index' do
    let(:presenter) { double(orders: ['should be array of orders']) }

    before do
      expect(OrdersPresenters::Index).to receive(:new).and_return(presenter)

      get :index
    end

    context 'response' do
      subject { response }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template('index') }
    end

    context 'assigns' do
      it 'fetches orders from presenter' do
        expect(assigns[:orders]).to eq presenter.orders
      end
    end
  end

  describe 'GET #show' do
    let(:order) { create(:order) }

    before { get :show, params: { number: order.number } }

    context 'response' do
      subject { response }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template('show') }
    end

    context 'assigns' do
      it 'fetches order by order number' do
        expect(assigns[:order]).to be_an_instance_of(Order)
        expect(assigns[:order].id).to eq order.id
      end
    end
  end

  describe 'GET #cancel' do
    let(:service) { double }
    let(:order) { create(:order) }

    before do
      expect(OrdersService).to receive(:new).with(kind_of(Order)).and_return(service)
      expect(service).to receive(:cancel)

      delete :cancel, params: { number: order.number }
    end

    context 'response' do
      subject { response }

      it { is_expected.to have_http_status(:found) }
      it { is_expected.to redirect_to(orders_path) }
    end

    context 'assigns' do
      it 'fetches order by order number' do
        expect(assigns[:order]).to be_an_instance_of(Order)
        expect(assigns[:order].id).to eq order.id
      end
    end
  end
end
