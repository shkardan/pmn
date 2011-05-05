xml.instruct!
xml.Response do
    xml.Say "You Entered #{@say_digits}."
    xml.Say "#{@call.reply_message}"  
    xml.Say "Goodbye!"    
    xml.Hangup
end