class Post < ApplicationRecord
  belongs_to :user
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }
  
  has_many_attached :images
  
  paginates_per 9
  
  
end
