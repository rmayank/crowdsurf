class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.references :performance
      t.string :uri
      t.string :displayName
      t.string :identifier

      t.timestamps
    end
  end

  def self.down
    drop_table :artists
  end
end
