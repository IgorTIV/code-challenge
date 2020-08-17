class OrdersController < ApplicationController
  before_action :find_order!, only: %w[show cancel]

  def index
    presenter = OrdersPresenters::Index.new(permitted_params)
    @orders = presenter.orders
  end

  def show
  end

  def cancel
    OrdersService.new(@order).cancel
    redirect_to orders_path, notice: "The order #{@order.number} was canceled"
  end

  private

  def find_order!
    @order = Order.find_by!(number: params[:number])
  end

  def permitted_params
    params.permit(:number)
  end
end
