class AddAttachmentLocalVideofileToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :local_videofile
    end
  end

  def self.down
    remove_attachment :videos, :local_videofile
  end
end
