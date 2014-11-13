class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@videos = Video.all
	end

end
