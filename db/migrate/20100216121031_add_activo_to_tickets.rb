class AddActivoToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :activo, :boolean, :default => true
  end

  def self.down
    remove_column :tickets, :activo
  end
end
