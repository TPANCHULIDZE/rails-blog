FactoryBot.define do
  factory :post do
    id {1}
    title { "new post" }
    body { "this is new post" }
    user_id { create(:user).id }
    
  end

end