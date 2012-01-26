class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.references :event
      t.string :zip
      t.decimal :lng, :precision => 15, :scale => 12
      t.decimal :lat, :precision => 15, :scale => 12
      t.string :uri
      t.string :displayName
      t.string :street
      t.string :website
      t.string :phone
      t.string :capacity
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end
