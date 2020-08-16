module OrdersPresenters
  class Index
    attr_reader :number

    def initialize(params)
      @number = params[:number]
    end

    def orders
      @orders ||= begin
        scope = number.present? ? Order.by_number(number) : Order
        scope.includes(:user).all
      end
    end
  end
end
