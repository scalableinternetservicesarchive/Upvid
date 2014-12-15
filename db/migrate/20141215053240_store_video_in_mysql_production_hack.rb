class StoreVideoInMysqlProductionHack < ActiveRecord::Migration
  def self.up
        execute 'ALTER TABLE local_videofiles MODIFY file_contents LONGBLOB'
        execute 'set GLOBAL max_allowed_packet=167772160'
  end

end
