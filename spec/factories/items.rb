FactoryBot.define do
  factory :item do
    description { Faker::Lorem.paragraphs }
    association :itemable, factory: :quotation
    quantity 2
    price "100.00"
    total_price "200.00"
  end
end
