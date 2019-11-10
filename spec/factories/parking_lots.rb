FactoryBot.define do
  factory :parking_lot do
    carpark_number {Faker::Lorem.characters(number: 5).upcase}
    total_lots {Faker::Number.number(digits: 3)}
    lot_type {Faker::Lorem.characters(number: 1).upcase}
    lots_available {total_lots - rand(total_lots)}
  end
end
