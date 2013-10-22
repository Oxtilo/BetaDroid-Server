class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :uid
      t.string :name
      t.string :email
      t.string :access_token
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
