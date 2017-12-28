FactoryBot.define do
  factory :company_profile do
    association :user, factory: :user
    company_name { Faker::Name.name }
    contact_number { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
    postcode { Faker::Address.postcode }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    logo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'media', 'avatar.png')) }
    reg_num { Faker::Code.asin }
  end
end
