class Friend < ApplicationRecord
    validates :user_id, presence: true
    validates :friend_id, presence: true
    validates :friend_id, uniqueness: { scope: [:user_id, :friend_id] }
    belongs_to :user
end
