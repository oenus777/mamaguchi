class FollowersController < ApplicationController
  def index
    @user = User.find(params[:id])
    @followers = @user.followers
  end
end
