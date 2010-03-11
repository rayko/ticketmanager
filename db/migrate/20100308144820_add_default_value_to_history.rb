class AddDefaultValueToHistory < ActiveRecord::Migration
  def self.up
    change_column :histories, :pagado, :boolean, :default => false
  end

  def self.down
    change_column :histories, :pagado, :boolean
  end
end
