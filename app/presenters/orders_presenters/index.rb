module OrdersPresenters
  class Index
    attr_reader :number, :page

    def initialize(params)
      @number = params[:number]
      @page = params[:page]
    end

    def orders
      @orders ||= begin
        scope = number.present? ? Order.by_number(number) : Order
        scope.includes(:user).page(page)
      end
    end
  end
end
