class Txt < ActiveRecord::Base

  require 'twiliolib'

  def twilio_send_sms
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

  def coupon_owner
    self.body.scan(/\w+/) { |c|      
      coupon = Coupon.find_by_code(c.to_s)
      unless coupon.nil?
        return coupon.user
      end
    }
    nil
  end

end
