class HomeController < ApplicationController
  before_action :all_posts, only: %i[index]
  
  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @follow_posts = Post.all
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
  
end
