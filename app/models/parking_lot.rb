class ParkingLot < ApplicationRecord
  validates_presence_of :carpark_number, :lot_type

  belongs_to :car_parking, foreign_key: :carpark_number, primary_key: :car_park_no
end
