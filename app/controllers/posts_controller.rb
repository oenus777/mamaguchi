# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create edit update destroy search]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]
  before_action :all_rank, only: %i[index show]

  def index
    @posts = Post.with_attached_images.page(params[:page])
    @categories = Category.all
  end

  def show
    @user = User.find(@post.user_id)
    @comment = Comment.new(post_id: @post.id)
    @post_comments = Comment.where(post_id: params[:id])
    @category_ranks = Post.group(:id).where(id: Like.group(:post_id)
                          .where(created_at: Time.now.prev_month..Time.now)
                          .order('count(post_id) desc').pluck(:post_id))
                          .where(category_id: @post.category_id).limit(3)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "#{@post.title}を新規投稿しました"
      redirect_to post_path(@post)
    else
      flash[:alert] = "#{@post.title}を投稿できませんでした"
      render :new
    end
  end

  def edit; end

  def update
    @post.update(post_params)
    flash[:notice] = "#{@post.title}の編集が完了しました"
    redirect_to post_path(@post)
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
    @q = Post.ransack(search_params)
    @posts = @q.result.with_attached_images.page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:title,
                                 :content, :category_id,
                                 images: [])
          .merge(user_id: current_user.id)
  end

  def search_params
    params.require(:q).permit(:title_or_content_cont)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def all_rank
    @all_ranks = Post.find(Like.group(:post_id).where(created_at: Time.now.prev_month..Time.now)
                    .order('count(post_id) desc').limit(3).pluck(:post_id))
  end
  
  def correct_user
    redirect_to root_path, alert: "アクセスできません" unless current_user == @post.user
  end
end
