FactoryBot.define do
  factory :notificatio do
    send_id { "" }
    receive_id { 1 }
    post_id { 1 }
    comment_id { 1 }
    action { "MyString" }
    checked { false }
  end
end
