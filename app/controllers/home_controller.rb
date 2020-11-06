# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :all_posts, only: %i[index]
  before_action :all_rank, only: %i[index]

  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @follow_posts = @user.following_users_feeds.with_attached_images.page(params[:page])
      @categories = Category.all
      @recommend_users = User.find(Post.where.not(user_id: current_user.id).order(created_at: :desc).limit(3).pluck(:user_id))
    else
      @all_posts.limit(9)
    end
  end

  def about; end

  private

  def all_posts
    @all_posts = Post.with_attached_images.page(params[:page])
  end

  def all_rank
    @all_ranks = Post.find(Like.group(:post_id).where(created_at: Time.now.prev_month..Time.now).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

end
