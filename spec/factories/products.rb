FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    sequence(:sku) { |n| "Sku#{n}" }
    msrp { 100 }
    cost { 100 }
  end
end
