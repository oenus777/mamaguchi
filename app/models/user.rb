class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         #:confirmable, 
         :lockable, :timeoutable
         
  has_one_attached :image
  
  def follow(user)
    followings << user
  end

  def unfollow(user)
    relationship = self.relationships.find_by(follow_id: user.id)
    relationship.destroy if relationship
  end

  def following?(user)
    self.followings.include?(user)
  end
  
  
         
  validates :name, presence: true, length: { maximum: 8 }
  
end
