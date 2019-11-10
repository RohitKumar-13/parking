require 'rails_helper'

module ParkingAvailabilityMigrator
  RSpec.describe Base do
    subject {ParkingAvailabilityMigrator::Base}

    describe '#initialize' do
      it 'assigns instance variable @batches' do
        object = subject.new

        expect(object.batches).to be_instance_of(Array)
        expect(object.batches).to be_empty
      end
    end

    describe '#run!' do
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

      it 'adds entries to ParkingLot' do
        object = subject.new

        object.run!

        expect(ParkingLot.count).to be(10)
      end
    end
  end
end