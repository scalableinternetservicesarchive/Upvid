class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message
      t.references :video, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
