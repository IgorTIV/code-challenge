FactoryBot.define do
  factory :order do
    sequence(:number, 1000) { |n| n }
    state { 'building' }
    total { 50 }
    address
    user { address.user }

  end
end
