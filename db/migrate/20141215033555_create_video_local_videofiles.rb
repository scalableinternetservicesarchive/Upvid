class CreateVideoLocalVideofiles < ActiveRecord::Migration
  def self.up
    create_table :local_videofiles do |t|
      t.integer    :video_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :local_videofiles
  end
end
