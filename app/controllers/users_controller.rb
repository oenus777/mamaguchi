class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]
  
  def index
  end

  def show
    
  end
  
  private
  
  
end
