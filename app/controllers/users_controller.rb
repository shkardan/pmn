class UsersController < ApplicationController

  #require 'twiliolib'  
  
  #skip_before_filter :authorized?, :except => [:index, :show, :edit, :update, :destroy]
  skip_before_filter :authorized?, :only => [:create]

  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/home 

  # GET /users/1
  # GET /users/1.xml
  def show
    #@user = User.find_by_id(params[:id]) 

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end  

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    #@user = User.find_by_id(params[:id])
    @account = @user.account
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @challenge_code = session[:challenge_code]
    #@response_code = @user.response_code

    respond_to do |format|
      if @user.verified_response_code?(@challenge_code) and @user.add_account_save
        session[:user_id] = @user.id #unless @user.nil?
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        flash[:notice] = 'Invalid inputs, try again!'
        format.html { render :controller => "home", :action => "register" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    #@user = User.find_by_id(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    #reset_session

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

end
