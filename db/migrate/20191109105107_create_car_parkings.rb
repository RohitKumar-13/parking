class CreateCarParkings < ActiveRecord::Migration[6.0]
  def change
    create_table :car_parkings do |t|
      t.string :car_park_no, null: false
      t.string :address, null: false
      t.float :x_coord, null: false, index: true
      t.float :y_coord, null: false, index: true
      t.string :car_park_type, null: false
      t.string :type_of_parking_system, null: false
      t.string :short_term_parking
      t.string :free_parking
      t.boolean :night_parking, default: false
      t.integer :car_park_decks, default: 0
      t.float :gantry_height, default: 0.0
      t.boolean :car_park_basement, default: true

      t.timestamps

      t.index :car_park_no
      t.index [:x_coord, :y_coord]
      t.index :car_park_type
      t.index :type_of_parking_system
    end
  end
end
