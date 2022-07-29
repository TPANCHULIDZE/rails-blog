require 'faker'

FactoryBot.define do
  factory :post do
    title { Faker::Alphanumeric.alpha(number: 15) }
    body { Faker::Alphanumeric.alpha(number: 50) }
    user_id { create(:user).id }
  end
end