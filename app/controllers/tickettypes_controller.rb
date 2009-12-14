class TickettypesController < ApplicationController
  # GET /tickettypes
  # GET /tickettypes.xml
  def index
    @tickettypes = Tickettype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tickettypes }
    end
  end

  # GET /tickettypes/1
  # GET /tickettypes/1.xml
  def show
    @tickettype = Tickettype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tickettype }
    end
  end

  # GET /tickettypes/new
  # GET /tickettypes/new.xml
  def new
    @tickettype = Tickettype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tickettype }
    end
  end

  # GET /tickettypes/1/edit
  def edit
    @tickettype = Tickettype.find(params[:id])
  end

  # POST /tickettypes
  # POST /tickettypes.xml
  def create
    @tickettype = Tickettype.new(params[:tickettype])

    respond_to do |format|
      if @tickettype.save
        flash[:notice] = 'Tickettype was successfully created.'
        format.html { redirect_to(@tickettype) }
        format.xml  { render :xml => @tickettype, :status => :created, :location => @tickettype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tickettype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tickettypes/1
  # PUT /tickettypes/1.xml
  def update
    @tickettype = Tickettype.find(params[:id])

    respond_to do |format|
      if @tickettype.update_attributes(params[:tickettype])
        flash[:notice] = 'Tickettype was successfully updated.'
        format.html { redirect_to(@tickettype) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tickettype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tickettypes/1
  # DELETE /tickettypes/1.xml
  def destroy
    @tickettype = Tickettype.find(params[:id])
    @tickettype.destroy

    respond_to do |format|
      format.html { redirect_to(tickettypes_url) }
      format.xml  { head :ok }
    end
  end
end
