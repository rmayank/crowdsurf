class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.references :event
      t.string :city
      t.decimal :lng, :precision => 15, :scale => 12
      t.decimal :lat, :precision => 15, :scale => 12

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
