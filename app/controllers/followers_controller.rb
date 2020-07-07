# frozen_string_literal: true

class FollowersController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  
  def index
    @user = User.find(params[:id])
    @followers = @user.followers
  end
end
