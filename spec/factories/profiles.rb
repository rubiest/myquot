FactoryBot.define do
  factory :profile do
    association :user, factory: :user
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
    postcode { Faker::Address.postcode }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    default_picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'media', 'avatar.png')) }
  end
end
