class ParkingLot < ApplicationRecord
  validates_presence_of :carpark_number, :lot_type
end
