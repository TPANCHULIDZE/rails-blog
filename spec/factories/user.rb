require 'faker'

FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    status {1} 
    confirmed_at { Time.now }
  end
end
