FactoryBot.define do
  factory :order_item do
    state { 'sold' }
    association :source, factory: :product
    quantity { 4 }
    price { 67 }
  end
end
