class Ticket < ActiveRecord::Base
  validates_presence_of :tickettype_id
  validates_numericality_of :tickettype_id
  validates_presence_of :owner
end
