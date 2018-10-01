class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook]

  has_attached_file :profile, styles: {medium: "1280x720", thumb: "800x600", mini: "36x36"}
  validates_attachment_content_type :profile, content_type: /\Aimage\/.*\Z/

  has_many :company_users
  has_many :companies, through: :company_users 

  def self.from_omniauth(auth)
    where(provider: auth['provider'], uid: auth['uid']).first_or_create do |user|
      user.email = auth['info']['email']
      user.encrypted_password = Devise.friendly_token
      user.name = auth['info']['name']
      user.profile = open(auth['info']['image'])     
    end
  end
end
