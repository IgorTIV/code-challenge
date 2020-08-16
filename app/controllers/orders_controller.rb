class OrdersController < ApplicationController
  before_action :find_order!, only: :show

  def index
    presenter = OrdersPresenters::Index.new(permitted_params)
    @orders = presenter.orders
  end

  def show
  end

  private

  def find_order!
    @order = Order.find_by!(number: params[:number])
  end

  def permitted_params
    params.permit(:number)
  end
end
