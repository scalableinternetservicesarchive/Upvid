class VideosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_video, only: [:show, :edit, :update, :destroy, :stream]
  before_action :authenticate_user!, only:[:new, :edit, :update, :destroy]
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.paginate_by_sql("select videos.*, (select count(*) from favorite_videos where favorite_videos.video_id = videos.id) as favorite_count from videos ORDER BY favorite_count DESC", :page => params[:page], :per_page => 16)
    if request.xhr?
      render :partial=>"video_list"
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @comment = Comment.new
    @comments = Comment.where(:video_id => params[:id]).paginate(:page => params[:page], :per_page => 15).order('id DESC')
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    # directory = Rails.root.join('public/videos')
    # puts directory
    # name = params[:upload][:file].original_filename
    # path = File.join(directory, name)
    # File.open(path, "wb") { |f| f.write(params[:upload][:file].read) }

    @video = Video.new(video_params)
    @video.user = current_user
    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def stream
    send_file @video.videofile.url,
      type: 'video/mp4',
      disposition: 'inline',
      stream: true,
      buffer_size: 4096
  end

  # Add and remove favorite videos
  # for user
  def favorite
    set_video
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @video
      redirect_to :back, notice: 'You favorited "' + @video.title + "\"."
    
    elsif type == "unfavorite"
      current_user.favorites.delete(@video)
      redirect_to :back, notice: 'You removed "' + @video.title + "\" from favorites."

    else
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :category, :videofile, :local_videofile)
    end
end
