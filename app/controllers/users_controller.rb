class UsersController < ApplicationController
	  skip_before_action :verify_authenticity_token
	  before_action :authenticate_user!, only:[ :edit, :update, :destroy]

	def show
		@user = User.find(params[:id])
		@videos = Video.where(:user_id => params[:id]).paginate(:page => params[:page], :per_page => 15).order('id DESC')
		@comments = Comment.where(:user_id => params[:id]).paginate(:page => params[:page], :per_page => 10).order('id DESC')
	end

end
