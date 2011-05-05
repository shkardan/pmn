class AddBodyToCalls < ActiveRecord::Migration
  def self.up
    add_column :calls, :body, :string
    add_column :messages, :name, :string
  end

  def self.down
    remove_column :calls, :body
    remove_column :messages, :name
  end
end
