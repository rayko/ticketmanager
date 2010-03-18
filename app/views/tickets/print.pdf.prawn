counter = 0
@tickets.each do |t|
	pdf.text " "
  pdf.text "ID#{t.id}                                                                                                                                 #{DateTime.now.strftime('%d-%m-%Y %H:%M')}", :align => :center, :size => 8
  pdf.text " "
	pdf.text "Universidad Católica de Santiago del Estero", :align => :center, :size => 22
	pdf.text "Departamento Academico Rafaela", :align => :center, :size => 22
	pdf.text " "
	pdf.text "Valido como comprobante de pago", :align => :center, :size => 16
	pdf.text " "
	pdf.text "DNI: #{t.dni}", :align => :left, :size => 12
	pdf.text "Nombre: #{t.nombre}", :align => :left, :size => 12
	pdf.text "Cuota: #{session[:date] || Date.today.strftime('%m-%Y')}", :align => :left, :size => 12
	pdf.text "Razon: #{@razon}", :align => :left, :size => 12
	pdf.text " "
	pdf.text "Valor: $#{@monto.nil? ? t.valor : @monto}", :align => :right, :size => 16
	pdf.text "-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  ", :align => :center, :size => 11
  counter += 1
	if counter == 3
	  pdf.start_new_page
	  counter = 0
	end
end