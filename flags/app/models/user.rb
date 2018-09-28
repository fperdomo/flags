class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_attached_file :profile, styles: {medium: "1280x720", thumb: "800x600", mini: "36x36"}
  validates_attachment_content_type :profile, content_type: /\Aimage\/.*\Z/
end
