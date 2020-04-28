class HomeController < ApplicationController
  before_action :all_posts, only: %i[index]
  before_action :all_rank, only: %i[index]
  
  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @follow_posts = @user.following_users_feeds.with_attached_images.page(params[:page])
    else
      @all_posts.limit(9)
    end
  end

  def about
  end
  
  private
  
  def all_posts
    @all_posts = Post.with_attached_images.page(params[:page])
  end
  
  def all_rank
    @all_ranks = Post.find(Like.group(:post_id).where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).order('count(post_id) desc').limit(3).pluck(:post_id))
  end
  
end
