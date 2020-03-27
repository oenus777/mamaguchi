class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show edit update]
  before_action :signed_user, only: %i[index show edit update]
  
  def index
    
  end

  def show
    
  end
  
  def edit
    
  end
  
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
  
end
