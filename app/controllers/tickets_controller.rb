class TicketsController < ApplicationController
  # GET /tickets
  # GET /tickets.xml
  def index
  	debugger
    @tickets = Ticket.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tickets }
    end
  end
  
  # GET /tickets/1
  # GET /tickets/1.xml
  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.xml
  def new
    @ticket = Ticket.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets
  # POST /tickets.xml
  def create
    @ticket = Ticket.new(params[:ticket])

    respond_to do |format|
      if @ticket.save
        flash[:notice] = 'Ticket was successfully created.'
        format.html { redirect_to(@ticket) }
        format.xml  { render :xml => @ticket, :status => :created, :location => @ticket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.xml
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        flash[:notice] = 'Ticket was successfully updated.'
        format.html { redirect_to(@ticket) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.xml
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to(tickets_url) }
      format.xml  { head :ok }
    end
  end
  
  def expend
    @tickets = Ticket.find :all, :conditions => ["activo = ? AND empieza <= ?", true, Date.today.month]
    #busca todos los tickets impresos este mes.
    history_ids = History.find(:all, :conditions =>["created_at > ?", Date.today - Date.today.day]).map do |h| h.ticket_id end
    #elimino los tickets de ya emitidos
    @tickets.delete_if do |t| history_ids.include? t.id end
    	
  end  
  
  def print
  	@tickets = Ticket.find(params[:tickets_ids].split(",").map{|id| id.to_i })
  	@tickets.each do |t| 
  		t.pagadas += 1		# Se asume que sera cobrada
  		t.activo = false if t.pagadas == t.cantidad		# Si llego a la cantidad pedida se desactiva
  		t.save!
  		
  		History.new(:ticket_id => t.id, :cuota => t.pagadas).save!	# Se deja constancia que este ticket fue expendido
  	end
#  	require "prawn"p
#  	Prawn::Document.generate "#{RAILS_ROOT}/tmp/#{DateTime.now}_tickets.pdf" do
#  		tickets.each do |t|
#  			text "Universidad Católica de Santiago del Estero", :align => :center, :size => 28
#  			text "Nombre: #{t.nombre}             Cuota: #{t.pagadas}", :align => :left, :size => 16
#  			text "Valor: $#{t.valor}", :align => :right, :size => 16
#  		end  		
#  	end
  end
  
  def state
	@ticket = Ticket.find_by_dni(params[:dni].to_i) unless params[:dni].nil?
	@histories = @ticket.histories unless @ticket.nil?
  end
  
  def search
    @month = params[:mes].to_i
    @results = []
  	if request.post?
  	  @results = Ticket.find :all, :conditions => {:empieza => params[:mes]}
  	end
  end
end
