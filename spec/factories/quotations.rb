FactoryBot.define do
  factory :quotation do
    association :user, factory: :user
    association :client, factory: :client
    ref_number { Faker::Code.asin }
    valid_until { Faker::Date.forward(23) }
    status 0
    sub_total "1298.00"
    tax_rate "0.10"
    tax "129.80"
    total "1427.80"
    note { Faker::Lorem.paragraph(2) }
  end
end
