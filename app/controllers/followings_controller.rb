# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
    
  def index
    @user = User.find(params[:id])
    @followings = @user.followings
  end
end
