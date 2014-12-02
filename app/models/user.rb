class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :videos

  #Favorite videos
  has_many :favorite_videos
  has_many :favorites, through: :favorite_videos, source: :video
end
