class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password_salt
      t.string :password_hash
      t.string :primarynumber
      t.string :areacode
      t.string :countrycode

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
