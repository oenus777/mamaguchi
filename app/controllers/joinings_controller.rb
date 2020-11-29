class JoiningsController < ApplicationController
  def index
    @community = Community.find(params[:id])
    @joining_users = @community.joining_users
  end
end
