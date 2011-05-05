class AccountsController < ApplicationController

  #before_filter :logged_in?

  # GET /account[s]
  # GET /account[s].xml
  def index
    @accounts = @user.account

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /account[s]/1
  # GET /account[s]/1.xml
  def show
    @account = @user.account #.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /account[s]/new
  # GET /account[s]/new.xml
  def new
    @account = @user.account.build
    #@account = @user.account = Account.new
    @categories = Category.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /account[s]/1/edit
  def edit
    @account = @user.account #.find_by_id(params[:id])
    @categories = Category.find(:all)
  end

  # POST /account[s]
  # POST /account[s].xml
  def create    
    #@user.create_account( params[:account] )
    @account = @user.account.build( params[:account] )

    respond_to do |format|
      if @account.save
        flash[:notice] = 'Account was successfully created and added to user.'
        format.html { redirect_to @account  }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /account[s]/1
  # PUT /account[s]/1.xml
  def update
    @account = @user.account #Account.find(params[:id])
    unless Category.find_by_id(params[:category_ids]).nil?
      @account.categories = Category.find_by_id( params[:category_ids] )
    else
      @account.categories.delete_all
    end

    respond_to do |format|
      if @account.update_attributes( params[:account] )
        flash[:notice] = 'Account was successfully updated.'
        format.html { redirect_to @account }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /account[s]/1
  # DELETE /account[s]/1.xml
  def destroy
    @account = @user.account #.find_by_id(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to account_url }
      format.xml  { head :ok }
    end
  end
end
