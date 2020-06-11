FactoryBot.define do
  factory :user do
    id { 1 }
    name { "testmama" }
    email { "test@test.com" }
    password { "password3" }
    password_confirmation { "password3" }
    
    trait :other do
      id { 2 }
      name {"othermama" }
      email { "other@other.com" }
    end
  end
end