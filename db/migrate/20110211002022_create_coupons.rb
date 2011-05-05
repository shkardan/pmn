class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.integer :user_id
      t.string :code

      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
