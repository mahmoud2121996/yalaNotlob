class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # belongs_to :order 
  has_many :invited_users
  has_many :orders, through: :invited_users
  has_and_belongs_to_many :users
  has_and_belongs_to_many :groups
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  def email_required?
    false
  end

  has_attached_file :avatar, :default_url => "/system/users/avatars/000/000/default/user.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :friends
  has_many :notifications, foreign_key: :to_id

end
