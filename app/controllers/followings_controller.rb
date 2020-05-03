# frozen_string_literal: true

class FollowingsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @followings = @user.followings
  end
end
