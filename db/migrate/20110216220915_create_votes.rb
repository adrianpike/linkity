class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|

      t.integer :value, :default => 1
      t.integer :user_id
      
      t.integer :voted_id
      t.string  :voted_type

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
