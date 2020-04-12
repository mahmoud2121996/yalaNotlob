class Notification < ApplicationRecord
    belongs_to :from, class_name: "User", foreign_key: "from_id"
    belongs_to :to, class_name: "User", foreign_key: "to_id"


    scope :unread, ->{ where(read: 0) }
end