FactoryBot.define do
  factory :car_parking do
    car_park_no {Faker::Lorem.characters(number: 5).upcase}
    address {Faker::Address.full_address}
    x_coord {rand(1.1496..1.4784001)}
    y_coord {rand(103.594..104.0945001)}
    car_park_type {CarParking.car_park_types.values.sample}
    type_of_parking_system {CarParking.type_of_parking_systems.values.sample}
  end
end
