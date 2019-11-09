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
end
