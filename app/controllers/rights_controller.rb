class RightsController < ApplicationController
  # GET /rights
  # GET /rights.xml
  def index    
    @rights = Right.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rights }
    end
  end

  # GET rights/synch
  def synch
    if @rights = Right.synchronize.find(:all)
      flash[:notice] = 'Right table is syncrhonizaed and up-to-date.'
    else
      flash[:notice] = 'There was an error, contact the administrator!'
    end

    respond_to do |format|
      format.html { redirect_to(rights_path) }# index.html.erb
      format.xml  { render :xml => @rights }
    end
  end

  # GET /rights/1
  # GET /rights/1.xml
  def show
    @right = Right.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @right }
    end
  end

  # GET /rights/new
  # GET /rights/new.xml
  def new
    @right = Right.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @right }
    end
  end

  # GET /rights/1/edit
  def edit
    @right = Right.find(params[:id])
  end

  # POST /rights
  # POST /rights.xml
  def create
    @right = Right.new(params[:right])

    respond_to do |format|
      if @right.save
        flash[:notice] = 'Right was successfully created.'
        format.html { redirect_to(@right) }
        format.xml  { render :xml => @right, :status => :created, :location => @right }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @right.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rights/1
  # PUT /rights/1.xml
  def update
    @right = Right.find(params[:id])

    respond_to do |format|
      if @right.update_attributes(params[:right])
        flash[:notice] = 'Right was successfully updated.'
        format.html { redirect_to(@right) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @right.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rights/1
  # DELETE /rights/1.xml
  def destroy
    @right = Right.find(params[:id])
    #@right.destroy
    flash.now[:notice] = 'Contact the Admin to delete any right! this will delete controller from the ROOT Dir'

    respond_to do |format|
      format.html { redirect_to(rights_url) }
      format.xml  { head :ok }
    end
  end
end
