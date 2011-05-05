class CreateTxts < ActiveRecord::Migration
  def self.up
    create_table :txts do |t|
      t.string :sid
      t.string :to
      t.string :from
      t.text :body
      t.string :direction

      t.timestamps
    end
  end

  def self.down
    drop_table :txts
  end
end
