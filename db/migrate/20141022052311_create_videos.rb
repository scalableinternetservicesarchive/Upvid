class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :category
      t.string :location
      t.references :user, index: true
      t.timestamps
    end
  end
end
