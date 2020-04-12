class Order < ApplicationRecord
    Meal = ['break fast', 'launch', 'launch2']
    belongs_to :user 
    has_many :invited_users
    has_many :users, through: :invited_users
end
