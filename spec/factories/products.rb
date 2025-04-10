FactoryBot.define do
  factory :product do
    association :user
    name { "MyString" }
  end
end
