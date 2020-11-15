class CommunitiesController < ApplicationController
  before_action :set_community, only: %i[show edit update destroy]
  
  def index
  end
  
  def show
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    if @community.save
      flash[:notice] = "#{@community.name}を新規投稿しました"
      redirect_to community_path(@community)
    else
      flash[:alert] = "#{@community.name}を投稿できませんでした"
      render :new
    end
  end

  def edit
  end

  def update
    @community.update(community_params)
    flash[:notice] = "#{@community.name}の編集が完了しました"
    redirect_to community_path(@community)
  end

  def destroy
    if @community.destroy
      flash[:notice] = "#{@community.name}を削除しました"
      redirect_to root_path
    else
      flash[:alert] = "#{@community.name}を削除できませんでした"
      redirect_to @community
    end
  end
  
  private
  
  def community_params
    params.require(:community).permit(:name, :description).merge(user_id: current_user.id)
  end
  
  def set_community
    @community = Community.find(params[:id])
  end
end
