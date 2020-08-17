module ReportsPresenters
  class Index
    attr_reader :coupon_name, :sales_from, :sales_to, :coupons_page, :sales_page

    def initialize(params)
      @coupon_name = params[:coupon_name]
      @sales_to = params[:sales_to]
      @sales_from = params[:sales_from]
      @coupons_page = params[:coupons_page]
      @sales_page = params[:sales_page]
    end

    def coupons
      @coupons ||= begin
        scope = coupon_name.present? ? Coupon.by_name(coupon_name) : Coupon
        scope.includes(:order_items, :orders, :users).page(coupons_page)
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
          .select('products.*', Arel.sql('COUNT(*) AS count'), Arel.sql('SUM(order_items.price * order_items.quantity) AS revenue'))
          .page(sales_page)
      end
    end
  end
end
