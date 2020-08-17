FactoryBot.define do
  factory :payment do
    order
    state { 'refunded' }
    payment_type { 'CreditCard' }
    amount { 31 }
  end
end
