class CreateParkingLots < ActiveRecord::Migration[6.0]
  def change
    create_table :parking_lots do |t|
      t.string :carpark_number, null: false
      t.integer :total_lots, default: 0
      t.string :lot_type, null: false
      t.integer :lots_available, default: 0
      t.timestamps

      t.index :carpark_number
      t.index :lots_available
      t.index [:carpark_number, :lot_type], unique: true
      t.index [:carpark_number, :lots_available]
    end
  end
end
