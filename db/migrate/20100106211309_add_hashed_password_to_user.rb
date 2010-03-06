class AddHashedPasswordToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :hashed_password, :text
    add_column :users, :salt, :text
  end

  def self.down
    remove_column :hased_password, :salt
  end
end
