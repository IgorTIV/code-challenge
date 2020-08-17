FactoryBot.define do
  factory :address do
    address1 { 'Washington Street' }
    city { 'Chicago' }
    state { 'IL' }
    zipcode { '60606' }

    user
  end
end
