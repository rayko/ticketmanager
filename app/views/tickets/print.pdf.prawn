@tickets.each do |t|
	pdf.text "Universidad Católica de Santiago del Estero", :align => :center, :size => 28
	pdf.text "Nombre: #{t.nombre}             Fecha: #{Date.today}", :align => :left, :size => 16
	
	pdf.text "Valor: $#{@monto.nil? ? t.valor : @monto}", :align => :right, :size => 16
end  	