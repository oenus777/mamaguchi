FactoryBot.define do
  factory :comment do
    id { 1 }
    association :post,factory: :post,strategy: :build
    user { post.user }
    comment { "testtest" }
    
    trait :other do
      id { 2 }
      association :post,factory: :post
      user { post.user }
      comment { "hogehoge" }
    end

    
  end
end
