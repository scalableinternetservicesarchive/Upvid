class Video < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :users
	validates :title, presence: true, length: { maximum: 20 }
	validates :category, presence: true, length: {maximum: 20}
end
