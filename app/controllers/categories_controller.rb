# frozen_string_literal: true

class CategoriesController < ApplicationController
  def show
    @posts = Post.where(category_id: params[:id]).page(params[:page])
    @categories = Category.all
    @category = Category.find(params[:id])
    @category_ranks = Post.group(:id).where(id: Like.group(:post_id).where(created_at: Time.now.prev_month..Time.now)
                          .order('count(post_id) desc').pluck(:post_id)).where(category_id: params[:id]).limit(3)
  end
end
