class AddSomeMiscFields < ActiveRecord::Migration
  def self.up
    add_column :tickets, :termina, :date
    change_column :tickets, :empieza, :date
  end

  def self.down
    remove_column :tickets, :termina
    change_column :tickets, :empieza, :integer
  end
end
