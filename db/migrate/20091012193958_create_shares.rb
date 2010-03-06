class CreateShares < ActiveRecord::Migration
  def self.up
    create_table :shares, :force => false do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :shares
  end
end
