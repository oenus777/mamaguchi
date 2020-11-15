class CreateCommunities < ActiveRecord::Migration[6.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.string :description
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
      
      t.index %i[id user_id], unique: true
    end
  end
end
