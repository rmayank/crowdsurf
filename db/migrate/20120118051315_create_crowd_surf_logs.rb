class CreateCrowdSurfLogs < ActiveRecord::Migration
  def self.up
    create_table :crowd_surf_logs do |t|
      t.text :my_loger

      t.timestamps
    end
  end

  def self.down
    drop_table :crowd_surf_logs
  end
end
