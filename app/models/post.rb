class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }
  
  has_many_attached :images
  
  paginates_per 9
  
  def like(user)
    likes.create(user_id: user.id)
  end
  
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  def like?(user)
    like_users.include?(user)
  end
  
  def favorite(user)
    favorites.create(user_id: user.id)
  end
  
  def unfavorite(user)
    favorites.find_by(user_id: user.id).destroy
  end
  
  def favorite?(user)
    favorite_users.include?(user)
  end
  
end
