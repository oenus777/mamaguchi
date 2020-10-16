# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @comment.post.create_notification_comment!(current_user, @comment.id)
      flash[:notice] = 'コメントを投稿しました'
      redirect_to @comment.post
    else
      redirect_to post_path(@comment.post.id), flash: {
        comment: @comment,
        error_messages: @comment.errors.full_messages
      }
    end
  end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit(
      :post_id,
      :comment
    ).merge(user_id: current_user.id)
  end
end
