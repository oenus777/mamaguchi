class FavoritesController < ApplicationController
  protect_from_forgery :except => [:create,:destroy]
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    unless @post.favorite?(current_user)
      @post.favorite(current_user)
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @post = Favorite.find(params[:id]).post
    if @post.favorite?(current_user)
      @post.unfavorite(current_user)
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
