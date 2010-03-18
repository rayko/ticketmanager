class AddMontoToHistory < ActiveRecord::Migration
    add_column :histories, :monto, :integer
  def self.up
  end

  def self.down
    remove_column :histories, :monto
  end
end
