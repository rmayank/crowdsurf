class AddTimezonetoProcessvideo < ActiveRecord::Migration
  def self.up
    add_column :process_videos, :time_zone, :string
  end

  def self.down
    remove_column :process_videos, :time_zone
  end
end
