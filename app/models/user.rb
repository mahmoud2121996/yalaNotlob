class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_and_belongs_to_many :users
  has_and_belongs_to_many :groups
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_attached_file :avatar, :default_url => "/system/users/avatars/000/000/default/user.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :friends
  has_many :notifications, foreign_key: :to_id

end
