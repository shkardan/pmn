class AddColumnsToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :sid,         :string
    add_column :messages, :date_created,:string
    add_column :messages, :date_updated,:string
    add_column :messages, :date_sent,   :string
    add_column :messages, :account_sid, :string
    add_column :messages, :from,        :string
    add_column :messages, :to,          :string
    add_column :messages, :status,      :string
    add_column :messages, :direction,   :string
    add_column :messages, :price,       :string
    add_column :messages, :api_version, :string
    add_column :messages, :uri,         :string
    add_column :messages, :user_id,     :integer
    remove_column :messages, :title
  end

  def self.down
    remove_column :messages, :sid
    remove_column :messages, :date_created
    remove_column :messages, :date_updated
    remove_column :messages, :date_sent
    remove_column :messages, :account_sid
    remove_column :messages, :from
    remove_column :messages, :to
    remove_column :messages, :status
    remove_column :messages, :direction
    remove_column :messages, :price
    remove_column :messages, :api_version
    remove_column :messages, :uri
    remove_column :messages, :user_id
    add_column :messages, :title,       :string
  end
end
