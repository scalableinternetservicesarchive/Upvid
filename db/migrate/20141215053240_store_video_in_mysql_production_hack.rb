class StoreVideoInMysqlProductionHack < ActiveRecord::Migration
  def self.up
        execute 'ALTER TABLE local_videofiles MODIFY file_contents LONGBLOB'
  end

end
