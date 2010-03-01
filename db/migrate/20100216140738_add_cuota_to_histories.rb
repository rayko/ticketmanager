class AddCuotaToHistories < ActiveRecord::Migration
  def self.up
    add_column :histories, :cuota, :integer
  end

  def self.down
    remove_column :histories, :cuota
  end
end
