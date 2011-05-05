class Txt < ActiveRecord::Base


  #attr_accessible

  #VALIDATIONS***************************************************************
  validates_presence_of     :from 

  def twilio_send_sms
    require 'twiliolib'
    # Create a Twilio REST account object using your Twilio account ID and token
    api_version = TWILIO_CONFIG["api_version"]
    account_sid = TWILIO_CONFIG["account_sid"]
    account_token = TWILIO_CONFIG["account_token"]
    caller_id = TWILIO_CONFIG["caller_id"]
    twilio = Twilio::RestAccount.new(account_sid, account_token)
    sms = {
    'From' => caller_id.to_s, # self.from,
    'To' => self.to,
    'Body' => self.body,
    }
    twilio.request("/#{api_version}/Accounts/#{account_sid}/SMS/Messages", 'POST', sms)

  end

  def twilio_reply_sms
    require 'twiliolib'
    # Create a Twilio REST account object using your Twilio account ID and token
    api_version = TWILIO_CONFIG["api_version"]
    account_sid = TWILIO_CONFIG["account_sid"]
    account_token = TWILIO_CONFIG["account_token"]
    caller_id = TWILIO_CONFIG["caller_id"]
    twilio = Twilio::RestAccount.new(account_sid, account_token)
    sms = {
    'From' => caller_id.to_s, # self.from,
    'To' => self.from,
    'Body' => 'thank you hassan!',
    }
    twilio.request("/#{api_version}/Accounts/#{account_sid}/SMS/Messages", 'POST', sms)

  end

  def match_coupon?(sms)
    unless coupon_owner.nil?
      user = coupon_owner
      message = user.messages.build(sms) #<< Message.new(sms)
      message.save
      self.reply_message = message.discount
      return true
    else
      self.reply_message = 'Did not find a coupon match!'
      return false
    end

  end


  def match_sms_coupon?

    self.body.scan(/\w+/) { |c|
      coupon = Coupon.find_by_code(c.to_s.upcase)
      unless coupon.nil?
        user = coupon.user
        message = user.messages.build( :from => self.from, :body => self.body ) #<< Message.new(sms)
        message.save
        self.reply_message = message.discount
        return true
      end
    }
    self.reply_message = 'Did not find a coupon match!'
    return false

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
    self.body.scan(/\w+/) { |c|      
      coupon = Coupon.find_by_code(c.to_s.upcase)
      unless coupon.nil?
        return coupon.user
      end
    }
    nil
  end

end
