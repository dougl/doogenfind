class AddCounterCacheToShares < ActiveRecord::Migration
  def self.up
    add_column :shares, :votes_count, :integer, :default => 0
    Share.find(:all).each do |s|
      s.update_attribute :votes_count, s.votes.length
  end
end

  def self.down
    remove_column :shares, :votes_count
  end
end
