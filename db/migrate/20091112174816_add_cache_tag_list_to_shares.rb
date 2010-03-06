class AddCacheTagListToShares < ActiveRecord::Migration
  def self.up
    add_column :shares, :cached_tag_list, :string
  end

  def self.down
    remove_column :shares, :cached_tag_list
  end
end
