class Comment < ActiveRecord::Base

	belongs_to :user
	belongs_to :video

	validates :user, presence: true
	#validates :video, presence: true

end
