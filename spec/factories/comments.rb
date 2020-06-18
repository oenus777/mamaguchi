FactoryBot.define do
  factory :comment do
    id { 1 }
    association :post
    user { post.user }
    comment { "testtest" }
    
    trait :other do
      id { 2 }
      post_id { 1 }
      user { post.user }
      comment { "hogehoge" }
    end

    
  end
end
