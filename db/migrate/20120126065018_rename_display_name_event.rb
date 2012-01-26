class RenameDisplayNameEvent < ActiveRecord::Migration
  def self.up
    rename_column :events, :displayName, :displayname
  end

  def self.down
    rename_column :events, :displayname, :displayName
  end
end
