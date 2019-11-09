class CreateParkingLots < ActiveRecord::Migration[6.0]
  def change
    create_table :parking_lots do |t|
      t.string :carpark_number
      t.integer :total_lots
      t.string :lot_type
      t.integer :lots_available
      t.timestamps

      t.index :carpark_number
      t.index :lots_available
      t.index [:carpark_number, :lot_type], unique: true
      t.index [:carpark_number, :lots_available]
    end
  end
end
