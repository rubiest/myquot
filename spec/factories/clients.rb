FactoryBot.define do
  factory :client do
    association :user, factory: :user
    uniq_id { Faker::Code.asin }
    contact_person_name { Faker::Name.name }
    contact_person_email { Faker::Internet.email }
    contact_person_phone { Faker::PhoneNumber.phone_number }
    company_name { Faker::Name.name }
    company_address { Faker::Address.street_address }
    company_postcode { Faker::Address.postcode }
    company_city { Faker::Address.city }
    company_state { Faker::Address.state }
    company_country { Faker::Address.country }
    company_email { Faker::Internet.email }
    company_phone_number { Faker::PhoneNumber.phone_number }
  end
end
