require 'rails_helper'

module ParkingAvailabilityMigrator
  RSpec.describe AvailabilityApi do
    subject {ParkingAvailabilityMigrator::AvailabilityApi}

    def carpark
      {
        carpark_number: Faker::Lorem.characters(number: 5).upcase,
        carpark_info: [
          {
            total_lots: Faker::Number.number(digits: 3),
            lot_type: Faker::Lorem.characters(number: 1).upcase,
            lots_available: Faker::Number.number(digits: 2)
          }
        ]
      }
    end

    let(:body) do
      {items: [{carpark_data: Array.new(10) {carpark}}]}
    end

    before {
      allow(HTTParty).to receive(:get).with('https://api.data.gov.sg/v1/transport/carpark-availability', any_args)
                           .and_return(OpenStruct.new(parsed_response: body.as_json))
    }

    describe '.fetch' do
      it 'returns list of ParkingLotAvailability' do
        result = subject.fetch

        expect(result.size).to be 10
        result.each do |r|
          expect(r).to be_instance_of(ParkingLotAvailability)
        end
      end
    end
  end
end