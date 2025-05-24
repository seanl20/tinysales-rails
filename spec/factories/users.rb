FactoryBot.define do
  factory :user do
    username { "testusername" }
    password { "password" }
    email { Faker::Internet.email }
  end
end
