class CreateFavoriteVideos < ActiveRecord::Migration
  def change
    create_table :favorite_videos do |t|
      t.string :video_id
      t.string :integer
      t.string :user_id
      t.string :integer

      t.timestamps
    end
  end
end
