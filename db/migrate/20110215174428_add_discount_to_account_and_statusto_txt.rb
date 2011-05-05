class AddDiscountToAccountAndStatustoTxt < ActiveRecord::Migration
  def self.up
    add_column  :accounts, :discount, :string
    add_column  :messages, :discount, :string
    add_column  :txts, :status, :string
  end

  def self.down
    remove_column  :accounts, :discount
    remove_column  :messages, :discount
    remove_column  :txts, :status
  end
end
