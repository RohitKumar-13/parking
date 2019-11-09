class ParkingLotAvailability
  attr_reader :carpark_number, :total_lots, :lot_type, :lots_available

  def initialize(params)
    @carpark_number = params['carpark_number']
    info = params['carpark_info'].first
    @total_lots = info['total_lots']
    @lot_type = info['lot_type']
    @lots_available = info['lots_available']
  end

  def to_h
    {
      carpark_number: carpark_number,
      total_lots: total_lots,
      lot_type: lot_type,
      lots_available: lots_available
    }
  end
end