# To change this template, choose Tools | Templates
# and open the template in the editor.

#puts "Hello World"

TWILIO_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/twilio.yml")).result)[Rails.env]

