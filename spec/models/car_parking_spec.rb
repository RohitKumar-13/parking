require 'rails_helper'

RSpec.describe CarParking, type: :model do
  subject {CarParking}

  let(:car_parking) {FactoryBot.build(:car_parking)}

  before(:all) do
    @parkings = Array.new(5) do
      car_parking = FactoryBot.create(:car_parking)
      FactoryBot.create(:parking_lot, carpark_number: car_parking.car_park_no)
      car_parking
    end
  end

  describe 'scope' do
    describe '#order_by_nearest_to' do
      let(:lat) {1.2496}
      let(:lng) {103.636386}

      it 'returns in order by distance to given location' do
        result = subject.order_by_nearest_to(lat, lng)

        result.each_with_index do |item, index|
          next if index == result.length - 1
          expect(item.distance).to be <= result[index + 1].distance
        end
      end
    end

    describe '#available' do
      it 'returns available parkings' do
        full_parking = @parkings.sample
        full_parking.parking_lots.first.update(lots_available: 0)

        result = subject.available

        result.each do |i|
          expect(i.car_park_no).not_to eq(full_parking.car_park_no)
        end
      end
    end
  end
end
