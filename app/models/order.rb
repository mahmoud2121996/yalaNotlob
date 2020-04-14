class Order < ApplicationRecord
    validates :order_for, presence: true
    validates :restaurant_name, presence: true

    belongs_to :user 
    has_many :invited_users
    has_many :users, through: :invited_users

    has_attached_file :image
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
