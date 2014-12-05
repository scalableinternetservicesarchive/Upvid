class AddAttachmentVideofileToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :videofile
    end
  end

  def self.down
    remove_attachment :videos, :videofile
  end
end
