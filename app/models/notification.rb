class Notification < ApplicationRecord
    
    default_scope -> { order(created_at: :desc) }
    
    belongs_to :post, optional: true
    belongs_to :comment, optional: true
    belongs_to :visiter, class_name: 'User', foreign_key: 'send_id', optional: true
    belongs_to :visited, class_name: 'User', foreign_key: 'receive_id', optional: true
end
