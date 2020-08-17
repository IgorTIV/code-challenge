require 'rails_helper'

RSpec.describe OrdersService do
  let!(:order)      { create(:order) }
  let!(:order_item) { create(:order_item, order: order) }
  let!(:payment)    { create(:payment, order: order, state: 'completed') }

  subject(:instance) { described_class.new(order) }

  its(:order) { is_expected.to eq order }

  describe '#cancel' do
    subject(:perform_cancel) { instance.cancel }

    it 'updates order state to canceled' do
      expect { perform_cancel }.to change { order.reload.state }.from('building').to('canceled')
      expect(order.canceled_at).not_to be_nil
    end

    it 'updates order items state to returned' do
      expect { perform_cancel }.to change { order_item.reload.state }.from('sold').to('returned')
    end

    it 'updates payments state to refunded' do
      expect { perform_cancel }.to change { payment.reload.state }.from('completed').to('refunded')
      expect(payment.refunded_at).not_to be_nil
    end
  end
end
