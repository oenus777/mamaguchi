FactoryBot.define do
  factory :user do
    name { "testmama" }
    email { "test@test.com" }
    password { "password3" }
    password_confirmation { "password3" }
    
    trait :other do
      name {"othermama" }
      email { "other@other.com" }
    end
  end
end