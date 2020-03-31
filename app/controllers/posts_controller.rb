class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]
  
  def index
    @posts = Post.with_attached_images.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "#{@post.title}を新規投稿しました"
      redirect_to current_user
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title,
    :content,
    images: [])
    .merge(user_id: current_user.id)
  end
  
  def user_posts
  end
end
