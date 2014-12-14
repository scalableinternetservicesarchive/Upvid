class Video < ActiveRecord::Base

  do_not_validate_attachment_file_type :local_videofile
  do_not_validate_attachment_file_type :videofile


	Paperclip.interpolates :content_type_extension  do |attachment, style_name|
  case
    when ((style = attachment.styles[style_name]) && !style[:format].blank?) then style[:format]
    when attachment.instance.video? && style_name.to_s == 'transcoded' then 'flv'
    when attachment.instance.video? && style_name.to_s != 'original' then 'jpg'
  else
    File.extname(attachment.original_filename).gsub(/^\.+/, "")
  end
	end


	has_attached_file :local_videofile,
                    :url => ':rails_root/public/system/:attachment/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/system/:attachment/:id/:style/:basename.:extension'

  has_attached_file :videofile,
                    :styles => { :thumb    => '115x115#' },
                    s3_permissions:  :private,
                    s3_host_name:    's3-us-west-1.amazonaws.com',
                    s3_headers:      {'Expires'             => 1.year.from_now.httpdate,
                                      'Content-Disposition' => 'attachment'},
                    :processors => lambda { |a| a.video? ? [ :video_thumbnail ] : [ :thumbnail ] },
                     :path => "video/:id/:style/:filename"


  after_save :queue_upload_to_s3


  def queue_upload_to_s3
     Rails.logger.debug "inside queue_upload_to_s3\n"*10
    Delayed::Job.enqueue VideoJob.new(id) if local_videofile? && local_videofile_updated_at_changed?
  end


  def upload_to_s3
    self.videofile = local_videofile.to_file
    save!
  end

  VideoJob = Struct.new(:id) do
    def perform
      Rails.logger.debug "inside perform\n"*10
      video = Video.find(id)
      video.upload_to_s3
      videofile.local_videofile.destroy
    end
  end


  def video?
    [ 'application/x-mp4',
      'video/mpeg',
      'video/quicktime',
      'video/x-la-asf',
      'video/x-ms-asf',
      'video/x-msvideo',
      'video/x-sgi-movie',
      'video/x-flv',
      'flv-application/octet-stream',
      'video/3gpp',
      'video/3gpp2',
      'video/3gpp-tt',
      'video/BMPEG',
      'video/BT656',
      'video/CelB',
      'video/DV',
      'video/H261',
      'video/H263',
      'video/H263-1998',
      'video/H263-2000',
      'video/H264',
      'video/JPEG',
      'video/MJ2',
      'video/MP1S',
      'video/MP2P',
      'video/MP2T',
      'video/mp4',
      'video/MP4V-ES',
      'video/MPV',
      'video/mpeg',
      'video/mpeg4',
      'video/mpeg4-generic',
      'video/nv',
      'video/parityfec',
      'video/pointer',
      'video/raw',
      'video/rtx' ].include?(videofile.content_type)
  end




	belongs_to :user
	has_and_belongs_to_many :users
	has_many :comments
	validates :title, presence: true, length: { maximum: 20 }
	validates :category, presence: true, length: {maximum: 20}

	#Favorited by users
	has_many :favorite_videos
	has_many :favorited_by, through: :favorite_videos, source: :user
end
