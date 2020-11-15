class Community < ApplicationRecord
    belongs_to :user
    has_many :joining_users, class_name: "CommunityRelationship", foreign_key: "community_id"
    
    has_one_attached :image
end
