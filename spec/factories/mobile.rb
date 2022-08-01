require 'faker'

FactoryBot.define do
  factory :mobile do
    number { "574" + Faker::Number.number(digits: 6).to_s  }
    country { "GE" }
    user_id { create(:user).id }
  end
end