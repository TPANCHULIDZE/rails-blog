FactoryBot.define do
  factory :user do
    id {1}
    username { "member" }
    email {"tatopanchulidze@gmail.com}"}
    password {"123456789"}
    status {1} 
  end
end