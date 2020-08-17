FactoryBot.define do
  factory :user do
    name { 'Bob' }
    sequence(:email) { |n| "bob#{n}@example.com" }
  end
end
