# frozen_string_literal: true
  before_action :authenticate_user!, only: %i[index]

class FollowersController < ApplicationController
  def index
    @user = User.find(params[:id])
    @followers = @user.followers
  end
end
