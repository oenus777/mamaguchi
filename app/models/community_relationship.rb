class CommunityRelationship < ApplicationRecord
    belongs_to :community
    belongs_to :user
    
    validates :comunnity_id, presence: true
    validates :user_id, presence: true
end
