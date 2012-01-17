class CreateRawVideos < ActiveRecord::Migration
  def self.up
    create_table :raw_videos do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.float :latitude
      t.float :longitude
      t.string :video_link
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :raw_videos
  end
end
