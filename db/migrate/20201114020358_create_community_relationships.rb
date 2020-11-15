class CreateCommunityRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :community_relationships do |t|
      t.references :community, foreign_key: true
      t.references :user, foreign_key: true
      
      t.timestamps
      
      t.index %i[community_id user_id], unique: true
    end
  end
end
