FactoryBot.define do
  factory :location do
    street { "Kostava" }
    city { "Kutaisi"}
    state { "Imereti"}
    country { "Georgia" } 
    latitude { 42.2345 }
    longitude { 42.2323 }
    user_id { create(:user).id }
  end
end