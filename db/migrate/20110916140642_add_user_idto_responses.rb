class AddUserIdtoResponses < ActiveRecord::Migration
  def self.up
    add_column :responses, :user_id, :integer
  end

  def self.down
    remove_columng :respones, :user_id
  end
end
