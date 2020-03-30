class AddFavoritesCountToPosts < ActiveRecord::Migration[6.0]
  class MigrationUser < ApplicationRecord
    self.table_name = :posts
  end

  def up
    _up
  rescue => e
    _down
    raise e
  end

  def down
    _down
  end

  private

  def _up
    MigrationUser.reset_column_information

    add_column :posts, :favorites_count, :integer, null: false, default: 0 unless column_exists? :posts, :favorites_count
  end

  def _down
    MigrationUser.reset_column_information

    remove_column :posts, :favorites_count if column_exists? :posts, :favorites_count
  end
end
