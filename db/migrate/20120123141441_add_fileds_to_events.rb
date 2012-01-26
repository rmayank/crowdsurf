class AddFiledsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :popularity, :decimal, :precision => 15, :scale => 12
    add_column :events, :uri, :string
    add_column :events, :displayName, :string
    add_column :events, :type, :string
  end

  def self.down
    remove_column :events, :type
    remove_column :events, :displayName
    remove_column :events, :uri
    remove_column :events, :popularity
  end
end
