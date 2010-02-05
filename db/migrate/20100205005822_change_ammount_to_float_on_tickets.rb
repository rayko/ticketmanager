class ChangeAmmountToFloatOnTickets < ActiveRecord::Migration
  def self.up
    change_column :tickettypes, :amount, :float, :default => 0
    change_column :tickettypes, :name, :string, :default => ''
    change_column :tickets, :paid, :boolean, :default => false
    change_column :tickets, :owner, :string, :default => ''
  end

  def self.down
    change_column :tickettypes, :amount, :string
    change_column :tickettypes, :name, :string
    change_column :tickets, :paid, :boolean
    change_column :tickets, :owner, :string
  end
end
