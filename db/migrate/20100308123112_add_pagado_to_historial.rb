class AddPagadoToHistorial < ActiveRecord::Migration
  def self.up
    add_column :histories, :pagado, :boolean
  end

  def self.down
    remove_column :histories, :pagado
  end
end
