class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@videos = Video.all
		@comments = Comment.all
	end

end
