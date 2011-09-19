class Users < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.string :salt
      t.string :auth_token
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
