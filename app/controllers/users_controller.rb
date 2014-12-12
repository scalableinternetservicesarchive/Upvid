class UsersController < ApplicationController
	  skip_before_action :verify_authenticity_token
	  before_action :authenticate_user!, only:[ :edit, :update, :destroy]

	def show
		@user = User.find(params[:id])
		@videos = Video.all
		@comments = Comment.all
	end

end
