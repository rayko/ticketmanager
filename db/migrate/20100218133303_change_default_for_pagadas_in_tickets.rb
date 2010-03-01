class ChangeDefaultForPagadasInTickets < ActiveRecord::Migration
  def self.up
  	change_column :tickets, :pagadas, :integer, :default => 0
  end

  def self.down
  	change_column :tickets, :pagadas, :integer
  end
end
