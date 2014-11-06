class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def index
    @comments = Comment.all
  end

  def show
    @comment
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    puts "params ", comment_params
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.save
    #Redirects to ID 1 temporarily
    @video = Video.find(1)
    redirect_to @video
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    if (@comment.user == current_user)
      @comment.destroy
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:message, :video_id)
    end
end
