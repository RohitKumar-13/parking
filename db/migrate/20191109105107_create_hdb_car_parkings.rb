class CreateHdbCarParkings < ActiveRecord::Migration[6.0]
  def change
    create_table :hdb_car_parkings do |t|
      t.string :car_park_no, null: false
      t.string :address, null: false
      t.float :x_coord, null: false, index: true
      t.float :y_coord, null: false, index: true
      t.string :car_park_type, null: false, index: true
      t.string :type_of_parking_system, null: false, index: true
      t.string :short_term_parking
      t.string :free_parking
      t.boolean :night_parking, default: false
      t.integer :car_park_decks, default: 0
      t.float :gantry_height, default: 0.0
      t.boolean :car_park_basement, default: true

      t.timestamps
    end
  end
end
