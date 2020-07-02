# frozen_string_literal: true
  before_action :authenticate_user!, only: %i[index]

class FollowingsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @followings = @user.followings
  end
end
