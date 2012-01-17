class UpdateColumnForLatLong < ActiveRecord::Migration
  def self.up
    remove_column :raw_videos, :latitude
    remove_column :raw_videos, :longitude
    add_column :raw_videos, :latitude, :decimal, :precision => 15, :scale => 12
    add_column :raw_videos, :longitude, :decimal, :precision => 15, :scale => 12
  end

  def self.down
  end
end
