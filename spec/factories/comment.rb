require 'faker'

FactoryBot.define do
  factory :comment do
    body { Faker::Alphanumeric.alpha(number: 20) }
    user_id { create(:user).id }
    post_id { create(:post).id }
    author { '' }
  end
end