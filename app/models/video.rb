class Video < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :users
	has_many :comments
	validates :title, presence: true, length: { maximum: 20 }
	validates :category, presence: true, length: {maximum: 20}

	#Favorited by users
	has_many :favorite_videos
	has_many :favorited_by, through: :favorite_videos, source: :user
end
