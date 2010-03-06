class AddDescriptionToShares < ActiveRecord::Migration
  def self.up
    add_column :shares, :description, :text
  end

  def self.down
    remove_column :shares, :description
  end
end
