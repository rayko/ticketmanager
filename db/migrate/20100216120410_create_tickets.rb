class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :nombre
      t.integer :dni
      t.integer :valor
      t.integer :cantidad
      t.integer :pagadas
      t.date :empieza

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
