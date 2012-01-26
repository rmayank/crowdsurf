class CreateStarts < ActiveRecord::Migration
  def self.up
    create_table :starts do |t|
      t.references :event
      t.time :time
      t.date :date
      t.datetime :datetime

      t.timestamps
    end
  end

  def self.down
    drop_table :starts
  end
end
