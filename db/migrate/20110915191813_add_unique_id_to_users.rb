class AddUniqueIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :unique_id, :integer
  end

  def self.down
    remove_column :users, :unique_id
  end
end
