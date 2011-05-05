xml.instruct!
  xml.Response do
    xml.Say "Hello there! Enter your four digit coupon now!"
      xml.Gather :action => @postto, :method => "GET", :numDigits => 4 do
      end
      xml.Hangup
  end