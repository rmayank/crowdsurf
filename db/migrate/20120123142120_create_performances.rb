class CreatePerformances < ActiveRecord::Migration
  def self.up
    create_table :performances do |t|
      t.references :event
      t.string :displayName
      t.string :billingIndex
      t.string :billing

      t.timestamps
    end
  end

  def self.down
    drop_table :performances
  end
end
