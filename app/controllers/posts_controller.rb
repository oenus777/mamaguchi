class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]
  before_action :set_post, only: %i[show edit update destroy]
  
  def index
    @posts = Post.with_attached_images.page(params[:page])
  end

  def show
    @user = User.find(@post.user_id)
    @comment = Comment.new(post_id: @post.id)
    @post_comments = Comment.where(post_id: params[:id])
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
    @post.update(post_params)
    flash[:notice] = "#{@post.title}の編集が完了しました"
    redirect_to root_path
  end

  def destroy
    if @post.destroy
      flash[:notice] = "#{@post.title}を削除しました"
      redirect_to root_path
    else
      flash[:alert] = "#{@post.title}を削除できませんでした"
      redirect_to @post
    end
  end
  
  def search
    @q = Post.search(search_params)
    @posts = @q.result.with_attached_images.page(params[:page])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title,
    :content,
    images: [])
    .merge(user_id: current_user.id)
  end
  
  def search_params
    params.require(:q).permit(:title_cont,:content_cont)
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  def user_posts
  end
end