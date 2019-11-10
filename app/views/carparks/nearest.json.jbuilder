car_parkings = @parkings.car_parkings.preload(:parking_lots)

json.array! car_parkings do |car_parking|
  json.address car_parking.address
  json.latitude car_parking.x_coord
  json.longitude car_parking.y_coord
  json.distance car_parking.distance

  slot = car_parking.parking_lots[0]
  json.total_slots slot.total_lots
  json.available_slots slot.lots_available
end