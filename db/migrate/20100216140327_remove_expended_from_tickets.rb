class RemoveExpendedFromTickets < ActiveRecord::Migration
  def self.up
  	remove_column :tickets, :expended
  end

  def self.down
  	add_column :tickets, :expended, :date
  end
end
