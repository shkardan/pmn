class Message < ActiveRecord::Base
  belongs_to :user, :foreign_key => "user_id"

  #attr_accessible

  #VALIDATIONS***************************************************************
  validates_presence_of     :user_id


  # FILTERS ********************************************************************
  before_save :check_fresh?

  after_save :calculate_discount
  

  # INSTANCE METHODS ***********************************************************

  def calculate_discount
    past_messages = self.user.messages.find_all_by_from( self.from )
    unless past_messages.nil?
      n = self.user.account.frequency
      case (past_messages.size.to_i % n)
      when 0
        self.discount = self.user.account.discount + ' on ' + Time.now.localtime.strftime('%F')
      when n-1
        self.discount = 'Next time ' + self.user.account.discount
      else
        self.discount = 'Thanks for the message :) Keep checking us out and we will surprise you!'
      end
      return
    end
    self.discount = 'Hello first-timer! Thank you for showing your support! ;) '

  end

  private
  
  # checks if 12 hours has past since last save with the same number?
  def check_fresh?
    past_messages = self.user.messages.find_by_from(:all, self.from)
    unless past_messages.nil?
      past_messages.each { |m|
        if 2.minutes.since( m.created_at.gmtime ) > Time.now.gmtime
          return false
        end
      }
    end
    return true

  end


end
