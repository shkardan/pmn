class User < ActiveRecord::Base  

  has_one :account #, :dependent => :destroy (DONT USE WITH BELONGS TO)
  has_and_belongs_to_many :roles
  #has_and_belongs_to_many :deals
  has_many  :messages
  has_many  :coupons #, :dependent => :destroy

  # For security pruposes, just to say that what values can be accessed via params[:*]
  attr_accessible  :username, :password, :password_confirmation, 
    :countrycode, :areacode, :primarynumber, :response_code

  #before_validation :is_authenticated?

  #VALIDATIONS***************************************************************
  validates_presence_of     :primarynumber, :username, :password_hash

  validates_uniqueness_of   :primarynumber, :username
  #validates_acceptance_of  :terms_of_service, :on => :create

  validates_format_of       :username, :with => /^([a-z0-9_]{4,16})$/i,
    :message => "must be 4 to 16 letters, numbers or underscores and have no spaces"

  validates_format_of       :password, :with => /^([\x20-\x7E]){4,16}$/,
    :message => "must be 4 to 16 characters"

  validates_confirmation_of :password

  attr_accessor :password_confirmation
  
  #FILTERS******************************************************************
  before_save :scrub_username, :flush_passwords
  #after_save :flush_passwords

  #CLASS METHODS************************************************************

  def self.find_by_username_and_password(username, password)
    user = self.find_by_username(username)
    if user and user.password_hash == encrypted_password(password, user.password_salt)
      return user
    end
  end

  #INSTANCE METHODS*********************************************************
  def generate_challenge_code    
    charset = %w{ 1 2 3 4 5 6 7 8 9 0 } #%w{A B C D E F G H J K L M N P Q R T V W X Y Z}
    self.challenge_code = (0...4).map{ Array(charset)[rand(charset.size)] }.join
  end

  def verify_response_code(challenge_code)
    self.response_code.upcase == challenge_code
  end

  def add_account_save
    self.account = Account.new(:frequency => '2')
    self.roles << Role.find_by_name('user')
    self.save
  end

  def send_sms
    require 'twiliolib'    
    # Create a Twilio REST account object using your Twilio account ID and token
    api_version = TWILIO_CONFIG["api_version"]
    account_sid = TWILIO_CONFIG["account_sid"]
    account_token = TWILIO_CONFIG["account_token"]
    caller_id = TWILIO_CONFIG["caller_id"]
    account = Twilio::RestAccount.new(account_sid, account_token)
    generate_challenge_code
    sms = {
    'From' => caller_id.to_s,
    'To' => self.countrycode.to_s + self.areacode.to_s + self.primarynumber.to_s,
    'Body' => self.challenge_code.to_s,
    }
    account.request("/#{api_version}/Accounts/#{account_sid}/SMS/Messages", 'POST', sms)

  end

  #VIRTUAL ATTRIBUTES********************************************************

  # custom setter method (input to database) needed fot the controller
  def challenge_code=(cc)
    @challenge_code = cc
  end

  #custom getter method (output from database) needed for the view
  def challenge_code
    @challenge_code
  end

  # custom setter method (input to database) needed fot the controller
  def response_code=(rc)
    @response_code = rc
  end

  #custom getter method (output from database) needed for the view
  def response_code
    @response_code
  end

  # 'password' is a virtual attribute

  #Now we need to write some code so that whenever a new plain-text password is
  #stored into a user object we automatically create a hashed version (which will
  #get stored in the database). We’ll do that by making the plain-text password a
  #virtual attribute of the model—it looks like an attribute to our application, but
  #it isn’t persisted into the database.

  #custom getter method (output from database)
  def password
    @password
  end

  # custom setter method (input to database)
  def password=(pwd)
    @password = pwd
    create_new_salt
    self.password_hash = User.encrypted_password(self.password, self.password_salt)
  end

  #OVERRIDE XML FOR SECURITY***************************************************
  def to_xml(options = {})
    default_only = [:id, :username, :countrycode, :areacode, :primarynumber]
    options[:only] = (options[:only] || []) + default_only
    super(options)
  end

  # PRIVATE METHODS*********************************************************
  private

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt # 'wibble' makes it harder to guess
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.password_salt = self.object_id.to_s + rand.to_s
  end

  def scrub_username
    self.username.downcase!
  end

  def flush_passwords
    @password = @password_confirmation = nil
  end
 
end
