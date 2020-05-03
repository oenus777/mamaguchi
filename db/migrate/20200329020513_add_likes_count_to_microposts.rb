# frozen_string_literal: true

class AddLikesCountToMicroposts < ActiveRecord::Migration[6.0]
  class MigrationUser < ApplicationRecord
    self.table_name = :posts
  end

  def up
    _up
  rescue StandardError => e
    _down
    raise e
  end

  def down
    _down
  end

  private

  def _up
    MigrationUser.reset_column_information

    unless column_exists? :posts, :likes_count
      add_column :posts, :likes_count, :integer, null: false, default: 0
    end
  end

  def _down
    MigrationUser.reset_column_information

    remove_column :posts, :likes_count if column_exists? :posts, :likes_count
  end
end
