class CouponsController < ApplicationController
  # GET /coupons
  # GET /coupons.xml
  def index
    #@coupons = Coupon.find(:all)
    @coupons = @user.coupons

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coupons }
    end
  end

  # GET /coupons/1
  # GET /coupons/1.xml
  def show
    #@coupon = Coupon.find(params[:id])
    @coupon = @user.coupons.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @coupon }
    end
  end

  # GET /coupons/new
  # GET /coupons/new.xml
  def new
    @coupon = Coupon.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @coupon }
    end
  end

  # GET /coupons/1/edit
  def edit
    #@coupon = Coupon.find(params[:id])
    @coupon = @user.coupons.find_by_id(params[:id])
  end

  # POST /coupons
  # POST /coupons.xml
  def create
    number = params[:number]    
    @coupons = Coupon.generate(@user, number)
    

    respond_to do |format|
      if @coupons
        flash[:notice] = 'Coupons were successfully created.'
        format.html { redirect_to( coupons_url ) } #:action => "index"
        format.xml
      else
        flash[:notice] = 'Coupon was not created.'
        format.html { redirect_to(:action => "new") }
        format.xml
      end
    end
  end

  # PUT /coupons/1
  # PUT /coupons/1.xml
  def update
    #@coupon = Coupon.find(params[:id])
    @coupon = @user.coupons.find_by_id(params[:id])

    respond_to do |format|
      if @coupon.update_attributes(params[:coupon])
        flash[:notice] = 'Coupon was successfully updated.'
        format.html { redirect_to( @coupon ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.xml
  def destroy
    @coupon = Coupon.find(params[:id])
    #@coupon = @user.coupons.find_by_id(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to( coupons_url ) }
      format.xml  { head :ok }
    end
  end
end
