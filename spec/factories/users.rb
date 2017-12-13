FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
    confirmed_at { Date.today }
    confirmation_sent_at { Date.today }
    role 0
  end

  factory :admin, class: User do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
    confirmed_at { Date.today }
    confirmation_sent_at { Date.today }
    role 1
  end
end
