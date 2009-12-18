class AddAmountToTickettype < ActiveRecord::Migration
  def self.up
    add_column :tickettypes, :amount, :string
  end

  def self.down
    remove_column :tickettypes, :amount
  end
end
