
class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.datetime :build_time
      t.integer :size
      t.text :permissions
      t.string :package
      t.integer :version_code
      t.string :version_name
      t.string :name
      t.integer :downloads, default: 0
      t.timestamps
    end
  end

  def self.down
    drop_table :releases
  end
end
