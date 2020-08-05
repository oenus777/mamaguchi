class ChangeColumnToComment < ActiveRecord::Migration[6.0]
  def up
    change_column :comments, :comment, :text
  end
end
