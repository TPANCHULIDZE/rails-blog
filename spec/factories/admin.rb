require 'faker'

FactoryBot.define do
  factory :admin do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    status { 2 } 
    confirmed_at { Time.now }
  end
end
