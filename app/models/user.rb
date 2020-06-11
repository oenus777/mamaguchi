# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :comment, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 15 },
                   uniqueness: { case_sensitive: true }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: true }
  validates_format_of :password, :with => /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/, :message => "は６文字以上の英数混在で入力してください。"
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         #:confirmable,
         :lockable, :timeoutable

  has_one_attached :image

  def following_users_feeds
    following_ids = "SELECT follow_id FROM relationships
                     WHERE user_id = :user_id"
    Post.where("user_id IN (#{following_ids})", user_id: id)
  end

  def follow(user)
    followings << user
  end

  def unfollow(user)
    relationship = relationships.find_by(follow_id: user.id)
    relationship&.destroy
  end

  def following?(user)
    followings.include?(user)
  end

end
