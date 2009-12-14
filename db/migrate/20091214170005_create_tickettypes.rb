class CreateTickettypes < ActiveRecord::Migration
  def self.up
    create_table :tickettypes do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :tickettypes
  end
end
