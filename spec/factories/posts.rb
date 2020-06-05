FactoryBot.define do
  factory :post, class: 'Posts' do
    title { "test" }
    content { "testtest" }
    association :user
    association :category
  end
end
