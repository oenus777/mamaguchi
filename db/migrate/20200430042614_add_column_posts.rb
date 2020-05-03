# frozen_string_literal: true

class AddColumnPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :category, index: true
  end
end
