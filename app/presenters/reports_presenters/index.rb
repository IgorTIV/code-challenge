module ReportsPresenters
  class Index
    attr_reader :coupon_name, :sales_from, :sales_to

    def initialize(params)
      @coupon_name = params[:coupon_name]
      @sales_to = params[:sales_to]
      @sales_from = params[:sales_from]
    end

    def coupons
      @coupons ||= begin
        scope = coupon_name.present? ? Coupon.by_name(coupon_name) : Coupon
        scope.includes(:order_items, :orders, :users).all
      end
    end

    def all_coupon_names
      @all_coupon_names ||= Coupon.pluck(:name)
    end

    def payment_ids
      @payment_ids ||= begin
        scope = Payment.completed
        scope = sales_from.present? ? scope.from_date(sales_from) : scope
        scope = sales_to.present? ? scope.to_date(sales_to) : scope
        scope.pluck(:id)
      end
    end

    def sales_by_product
      @sales_by_product ||= begin
        Product
          .joins(order_items: { order: :payments })
          .where(order_items: { state: "sold", orders: { payments: payment_ids } })
          .group(:id)
          .pluck('products.name', Arel.sql('COUNT(*)'), Arel.sql('SUM(order_items.price * order_items.quantity)'))
      end
    end
  end
end