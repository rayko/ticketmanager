class ChangeColumnCuotaInHistory < ActiveRecord::Migration
  def self.up
    change_column :histories, :cuota, :date
  end

  def self.down
    change_column :histories, :cuota, :integer
  end
end
