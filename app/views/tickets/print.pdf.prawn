@tickets.each do |t|
	pdf.text "Universidad Católica de Santiago del Estero", :align => :center, :size => 28
	pdf.text "Nombre: #{t.nombre}             Cuota: #{t.pagadas}", :align => :left, :size => 16
	pdf.text "Valor: $#{t.valor}", :align => :right, :size => 16
end  	