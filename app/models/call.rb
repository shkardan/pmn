class Call < ActiveRecord::Base
  #attr_accessible

  #VALIDATIONS***************************************************************
  validates_presence_of     :to, :from, :sid

  def match_coupon?(voice)
    unless coupon_owner.nil?
      user = coupon_owner
      message = user.messages.build(voice) #<< Message.new(sms)
      message.save
      self.reply_message = message.discount
      return true
    else
      self.reply_message = 'Did not find a coupon match!'
      return false
    end

  end

  #VIRTUAL ATTRIBUTES********************************************************

  # custom setter method (input to database) needed fot the controller
  def reply_message=(rm)
    @reply_message = rm
  end

  #custom getter method (output from database) needed for the view
  def reply_message
    @reply_message
  end

  private

  def coupon_owner
    self.body.scan(/\d+/) { |c|   #/\w+/
      coupon = Coupon.find_by_code(c.to_s.upcase)
      unless coupon.nil?
        return coupon.user
      end
    }
    nil
  end
end
