# frozen_string_literal: true

class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_index :users, :name, unique: true
  end
end
