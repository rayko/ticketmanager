class ChangeEmpiezaInTickets < ActiveRecord::Migration
  def self.up
  	remove_column :tickets, :empieza
  	add_column :tickets, :empieza, :integer, :maximum => 12, :minimum => 1
  end

  def self.down
  	remove_column :tickets, :empieza
  	add_column :tickets, :empieza, :date
  end
end
