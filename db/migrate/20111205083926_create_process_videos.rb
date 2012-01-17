class CreateProcessVideos < ActiveRecord::Migration
  def self.up
    create_table :process_videos do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.float :latitude
      t.float :longitude
      t.string :video_link
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :process_videos
  end
end
