FactoryBot.define do
  factory :notification do
    send_id { 1 }
    receive_id { 1 }
    post_id { 1 }
    comment_id { 1 }
    action { "MyString" }
    checked { false }
  end
end
