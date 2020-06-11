FactoryBot.define do
  factory :post do
    id { 1 }
    title { "test" }
    content { "testtest" }
    association :user
    association :category
  end
end
