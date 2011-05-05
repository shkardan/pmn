class Category < ActiveRecord::Base
  
  belongs_to :account, :foreign_key => "account_id"

  attr_accessible  :name, :description

end
