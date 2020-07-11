# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show edit update]
  before_action :signed_user, only: %i[index show]
  before_action :correct_user, only: %i[edit update]

  def index; end

  def show
    @posts = Post.where(user_id: @user.id).page(params[:page])
    @likes = @user.like_posts.page(params[:page])
    @favorites = @user.favorite_posts.page(params[:page])
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = "#{@user.name}さんのユーザー情報を更新しました"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def signed_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :image)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path, alert: "アクセスできません" unless current_user == @user
  end
end
