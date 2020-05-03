# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps

      t.index :user_id
      t.index :post_id
      t.index %i[user_id post_id], unique: true
    end
  end
end
