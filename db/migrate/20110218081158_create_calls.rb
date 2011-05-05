class CreateCalls < ActiveRecord::Migration
  def self.up
    create_table :calls do |t|
      t.string :sid
      t.string :from
      t.string :to
      t.string :status
      t.string :direction
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :calls
  end
end
