class HomeController < ApplicationController

  skip_before_filter :authorized?
  skip_before_filter :verify_authenticity_token 

  # GET /home/index
  def index
    
  end

  # USER LOGIN/OUT PROCESS ####################################################
  # 
  # POST /home/login
  # POST /home/login.xml
  def login
    @user = User.find_by_username_and_password(params[:username], params[:password]) #(params[:user])

    respond_to do |format|

      unless @user.nil?
        flash.now[:notice] = 'Successfully logged in!'
        session[:user_id] = @user.id
        format.html { redirect_to(@user) } 
        format.xml  { render :xml => @user } 
      else
        flash.now[:notice] = 'Login error, try again!'
        format.html { render :action => "index" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /home/logout
  def logout
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end

  #USER REGISTERATION PROCESS #################################################
  def register
    @user = User.new
  end

  # POST /home/verify
  # POST /home/verify.xml
  def verify
    @user = User.new(params[:user])
    @resp = @user.send_sms # AFTER send_sms, the challenge_code is generated!
    @challenge_code = @user.challenge_code
    session[:challenge_code] = @challenge_code

    respond_to do |format|
      format.html 
      format.xml  
    end
  end

  def create
    if request.post?
      @user = User.new(params[:user])
      @challenge_code = session[:challenge_code]

      if @user.verify_response_code(@challenge_code) and @user.add_account_save
        session[:user_id] = @user.id #unless @user.nil?
        flash[:notice] = 'User was successfully created.'
        redirect_to( @user )
      else
        flash[:notice] = 'Invalid inputs, try again!'
        redirect_to( :action => "register" )
      end
    end

  end

  #RECEIVE SMS FROM TWILIO PROCESS ###########################################
  # GET /messages/twilio_sms
  # GET /messages.xml
  def twilio_sms
    sms = {
    :sid => params[:SmsSid],    
    :from => params[:From],
    :to => params[:To],
    :body => params[:Body],
    #:status => params[:SmsStatus], # this will be used later for confirmation with Twilio    
    }
    @txt = Txt.new(sms)      
    
    @status_report = TWILIO_CONFIG["base_url"].to_s + '/home/twilio_status'

    #@txt.twilio_reply_sms

    respond_to do |format|
      if @txt.save and @txt.match_coupon?(sms)
        flash[:notice] = 'Message was successfully received.'        
        format.xml { @txt }
      else
        flash[:notice] = 'Delivery failed.'                
        format.xml { @txt }
      end
    end

  end

  def search_number
    require 'rubygems'
    require 'crack'
    require 'twiliolib'
    api_version = TWILIO_CONFIG["api_version"]
    account_sid = TWILIO_CONFIG["account_sid"]
    auth_token = TWILIO_CONFIG["account_token"]

    account = Twilio::RestAccount.new(account_sid, auth_token)
    url = "/#{api_version}/Accounts/#{account_sid}/AvailablePhoneNumbers/US/Local.json"

    search_params = {}
    search_params['InPostalCode'] = params['postal_code'] unless params['postal_code'].blank?
    search_params['NearNumber'] = params['near_number'] unless params['near_number'].blank?
    search_params['Contains'] = params['contains'] unless params['contains'].blank?

    @http_response = account.request(url, 'GET', search_params)

    @response = Crack::JSON.parse @http_response.body
    
  end


  def buy_number
    require 'rubygems'
    require 'twiliolib'
    require 'crack'
    api_version = TWILIO_CONFIG["api_version"]
    account_sid = TWILIO_CONFIG["account_sid"]
    auth_token = TWILIO_CONFIG["account_token"]

    account = Twilio::RestAccount.new(account_sid, auth_token)
    url = "/#{api_version}/Accounts/#{account_sid}/IncomingPhoneNumbers.json"
    @http_response = account.request(url, 'POST', {'PhoneNumber' => params[:PhoneNumber]})

    @response = Crack::JSON.parse @http_response.body
  
  end
      
end
