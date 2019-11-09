module ParkingAvailabilityMigrator
  module AvailabilityApi
    def self.fetch
      body = HTTParty.get(
        Constant::PARKING_AVAILABILITY,
        query: {
          date_time: Time.now.getlocal('+08:00').strftime('%FT%T')
        }
      ).parsed_response
      data = body['items'][0]['carpark_data'] || []
      data.map! do |parking|
        ParkingLotAvailability.new(parking)
      end
    end
  end
end