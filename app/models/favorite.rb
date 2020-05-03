# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  counter_culture :post
  validates :user_id, presence: true
  validates :post_id, presence: true
end
