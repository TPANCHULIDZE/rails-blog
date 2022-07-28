FactoryBot.define do
  factory :post do
    title { "new post" }
    body { "this is new post" }
    user_id { create(:user).id }
  end
end