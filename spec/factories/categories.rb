FactoryBot.define do
  factory :category do
    id { 1 }
    name { "test" }
    
    trait :other do
      id { 2 }
      name { "testtest" }
    end
  end
end
