class Account < ActiveRecord::Base
  belongs_to  :user, :foreign_key => "user_id"
  has_many    :categories

  #attr_accessible  
end
