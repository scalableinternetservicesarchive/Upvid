class UsersController < ApplicationController
	  before_action :authenticate_user!, only:[ :edit, :update, :destroy]

	def show
		@user = User.find(params[:id])
		@videos = Video.all
		@comments = Comment.all
	end

end
