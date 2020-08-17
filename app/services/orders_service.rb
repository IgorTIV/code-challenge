class OrdersService
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def cancel
    ActiveRecord::Base.transaction do
      order.update!(state: Order::CANCELED, canceled_at: Time.now)

      order.order_items.each do |item|
        item.update!(state: OrderItem::RETURNED)
      end

      order.payments.each do |payment|
        payment.update!(state: Payment::REFUNDED, refunded_at: Time.now)
      end
    end
  end
end
