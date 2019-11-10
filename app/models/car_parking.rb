class CarParking < ApplicationRecord
  enum car_park_type: {
    basement_car_park: 'BASEMENT CAR PARK',
    multi_storey_car_park: 'MULTI-STOREY CAR PARK',
    surface_car_park: 'SURFACE CAR PARK'
  }

  enum type_of_parking_system: {
    electronic_parking: 'ELECTRONIC PARKING',
    coupon_parking: 'COUPON PARKING'
  }

  has_many :parking_lots, primary_key: :car_park_no, foreign_key: :carpark_number

  scope :order_by_nearest_to, ->(lat, lng) {
    distance_order = Arel.sql("(6371 * 2 * ASIN (SQRT (POWER(SIN((#{lat} - COALESCE(#{table_name}.x_coord, 0.0)) * pi()/180 / 2), 2) + "\
      "COS(#{lat} * pi()/180) * COS(#{lat} * pi()/180) * POWER(SIN((#{lng} - COALESCE(#{table_name}.y_coord, 0.0)) * pi()/180 / 2), 2))))")
    order(distance_order)
  }

  scope :available, -> {
    joins(:parking_lots).where(ParkingLot.arel_table[:lots_available].gt(0))
  }
end
