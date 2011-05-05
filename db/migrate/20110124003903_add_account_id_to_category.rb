class AddAccountIdToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :account_id, :integer
  end

  def self.down
    remove_column :categories, :account_id
  end
end
