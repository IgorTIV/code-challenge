class ReportsController < ApplicationController
  def index
    presenter = ReportsPresenters::Index.new(permitted_params)

    @coupons = presenter.coupons
    @all_coupon_names = presenter.all_coupon_names

    @sales_by_product = presenter.sales_by_product
  end

  private

  def permitted_params
    params.permit(:coupon_name, :sales_from, :sales_to, :coupons_page, :sales_page)
  end
end
