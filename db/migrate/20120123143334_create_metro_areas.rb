class CreateMetroAreas < ActiveRecord::Migration
  def self.up
    create_table :metro_areas do |t|
      t.references :venue
      t.string :uri
      t.string :displayName
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :metro_areas
  end
end
