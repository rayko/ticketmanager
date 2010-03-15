class Ticket < ActiveRecord::Base
	has_many :histories
	
	validates_numericality_of :dni
	validates_numericality_of :valor
	validates_numericality_of :cantidad
	
	# validates_uniqueness_of :dni
end
