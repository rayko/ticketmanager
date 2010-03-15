# -*- coding: utf-8 -*-
class TicketsController < ApplicationController
  # GET /tickets
  # GET /tickets.xml
  def index
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
    temp_date = @ticket.empieza
    months = 0
    while temp_date < @ticket.termina do
      months += 1
      temp_date += 1.month
    end
    @ticket.cantidad = months
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
    @tickets = Ticket.find :all, :conditions => ["activo = ? AND empieza <= ?", true, Date.today]
    #busca todos los tickets impresos este mes.
    history_ids = History.find(:all, :conditions =>["created_at > ?", Date.today - Date.today.day]).map do |h| h.ticket_id end
    #elimino los tickets de ya emitidos
    @tickets.delete_if do |t| history_ids.include? t.id end

  end

  def print
    @tickets = Ticket.find(params[:tickets_ids].split(",").map{|id| id.to_i })
    @tickets.each do |t|       # Se asume que sera cobrada
      t.activo = false if t.cantidad == History.find(:all, :conditions => {:ticket_id => t.id, :pagado => true}).size             # Si llego a la cantidad pedida se desactiva
      t.save!
      
      History.new(:ticket_id => t.id, :cuota => Date.today.strftime('01-%m-%Y'), :pagado => false).save! unless not History.find(:all, :conditions => {:ticket_id => t.id, :cuota => Date.today.strftime('01-%m-%Y')}).empty?   # Se deja constancia que este ticket fue expendido
    end
  #       require "prawn"p
  #       Prawn::Document.generate "#{RAILS_ROOT}/tmp/#{DateTime.now}_tickets.pdf" do
  #               tickets.each do |t|
  #                       text "Universidad Católica de Santiago del Estero", :align => :center, :size => 28
  #                       text "Nombre: #{t.nombre}             Cuota: #{t.pagadas}", :align => :left, :size => 16
  #                       text "Valor: $#{t.valor}", :align => :right, :size => 16
  #               end
  #       end
    prawnto :filename => "#{DateTime.now}_ticket.pdf"
  end

  def state
    @tickets = Ticket.find(:all, :conditions => {:dni => params[:dni].to_i}) unless params[:dni].nil?
    @tickets.reject{|t| not t.activo}
    @histories = []
    @tickets.each do |ticket|
      temp = {}
      ticket.histories.each do |h|
        temp[h.created_at.to_date.strftime('%Y-%m-%d')] = h
      end
      @histories[ticket.id] = temp
    end unless @tickets.nil?
  end

  def search
    @month = params[:mes].to_i
    @results = []
    if request.post?
      # Como quiero obtener el dia final del mes que quiero, armo el primer dia del siguiente mes
      fecha = Date.parse "#{Date.today.year.to_s}-#{params[:mes].to_i + 1}-01"
      
      # Si le resto un dia, obtengo la fecha con el dia final del mes que quiero
      last_day = fecha - 1.day
      
      # Necesito tambien el primer dia, asi que le resto un mes a la fecha que hice antes
      fecha = fecha - 1.month
      # @results = Ticket.find :all, :conditions => ["empieza > ? AND empieza < ?", fecha, last_day]
      @results = Ticket.all.reject{|t| not last_day.between? t.empieza, t.termina}
    end
  end

  def payment
    @hisotiral = History.all
    if request.post?
      params[:tickets].each do |ticket_id|
        historial = History.find ticket_id.to_i
        historial.pagado = true
        historial.save!
        ticket = Ticket.find ticket_id.to_i
        ticket.activo = false if ticket.cantidad == History.find(:all, :conditions => {:ticket_id => ticket.id, :pagado => true}).size  
        ticket.pagadas += 1
        ticket.save!
      end
    end unless params[:tickets].nil?
  end
  
  def payment_cancellation
    ticket = Ticket.find params[:ticket_id]
    #ticket.activo = false
    #ticket.termina = Date.today
    #ticket.save!
    @monto = params[:monto].to_i
    @tickets = [ticket]
    prawnto :filename => "#{DateTime.now}_ticket.pdf"
    render :template => 'tickets/print.pdf.prawn', :layout => false
  end
  
  def cancellation
    ticket = Ticket.find params[:ticket_id]
    ticket.activo = false
    ticket.termina = Date.today
    # ticket.save!
  end
end
