class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories do |t|
      t.integer :ticket_id
      t.date :expended

      t.timestamps
    end
  end

  def self.down
    drop_table :histories
  end
end
