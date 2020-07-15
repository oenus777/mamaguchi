FactoryBot.define do
  factory :post do
    id { 1 }
    title { "test" }
    content { "testtest" }
    association :user
    association :category
    
    trait :other do
      id { 2 }
      title { "other" }
      content { "otherother" }
      association :user,:other
      association :category,:other
    end
  end
end
