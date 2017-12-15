FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
    confirmed_at { Date.today }
    confirmation_sent_at { Date.today }
    enterprise { false }
    role 0
  end

  factory :admin, class: User do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
    confirmed_at { Date.today }
    confirmation_sent_at { Date.today }
    enterprise { false }
    role 1
  end

  factory :user_with_profile, parent: :user do
    after(:build) do |user|
      user.profile = create(:profile)
    end
  end
end
