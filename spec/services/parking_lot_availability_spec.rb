require 'rails_helper'

RSpec.describe ParkingLotAvailability do
  subject {ParkingLotAvailability}

  let(:parking) do
    {
      carpark_number: Faker::Lorem.characters(number: 5).upcase,
      carpark_info: [
        {
          total_lots: Faker::Number.number(digits: 3),
          lot_type: Faker::Lorem.characters(number: 1).upcase,
          lots_available: Faker::Number.number(digits: 2)
        }
      ]
    }.as_json
  end

  describe '#initialize' do
    it 'assigns instance variable @carpark_number' do
      object = subject.new(parking)

      expect(object.instance_variable_get(:@carpark_number)).to eq(parking['carpark_number'])
    end

    it 'assigns instance variable @total_lots' do
      object = subject.new(parking)

      expect(object.instance_variable_get(:@total_lots)).to eq(parking['carpark_info'][0]['total_lots'])
    end

    it 'assigns instance variable @lot_type' do
      object = subject.new(parking)

      expect(object.instance_variable_get(:@lot_type)).to eq(parking['carpark_info'][0]['lot_type'])
    end

    it 'assigns instance variable @lots_available' do
      object = subject.new(parking)

      expect(object.instance_variable_get(:@lots_available)).to eq(parking['carpark_info'][0]['lots_available'])
    end
  end
end