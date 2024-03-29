class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :name
      t.text :desc

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
