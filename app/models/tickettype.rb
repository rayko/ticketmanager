class Tickettype < ActiveRecord::Base
  validates_presence_of :amount
  validates_numericality_of :amount
  validates_presence_of :name
  validates_uniqueness_of :name
end
