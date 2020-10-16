class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :send_id
      t.integer :receive_id
      t.integer :post_id
      t.integer :comment_id
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
      
      t.index :send_id
      t.index :receive_id
      t.index :action
    end
  end
end
