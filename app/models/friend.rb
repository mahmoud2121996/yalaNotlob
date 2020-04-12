class Friend < ApplicationRecord
    validates :user_id, uniqueness: { scope: [:user_id, :friend_id] }
    belongs_to :user
end
