require 'rails_helper'

RSpec.describe CarparksController, type: :controller do
  render_views

  describe '#nearest' do
    context 'when location in not provided in params' do
      context 'when latitude, longitude is missing' do
        it 'returns error' do
          get :nearest

          expect(response).to be_bad_request
          json = JSON.parse(response.body)

          expect(json['message']).to eq('Required params `latitude`,`longitude` missing from API.')
        end
      end

      context 'when latitude is missing' do
        it 'returns error' do
          get :nearest, params: {longitude: 103.636386}

          expect(response).to be_bad_request
          json = JSON.parse(response.body)

          expect(json['message']).to eq('Required params `latitude` missing from API.')
        end
      end

      context 'when longitude is missing' do
        it 'returns error' do
          get :nearest, params: {latitude: 1.2496}

          expect(response).to be_bad_request
          json = JSON.parse(response.body)

          expect(json['message']).to eq('Required params `longitude` missing from API.')
        end
      end
    end

    context 'when location is provided in params' do
      before(:all) do
        @parkings = Array.new(30) do
          car_parking = FactoryBot.create(:car_parking)
          FactoryBot.create(:parking_lot, carpark_number: car_parking.car_park_no)
          car_parking
        end
      end

      let(:params) do
        {latitude: 1.2496, longitude: 103.636386, format: :json}
      end

      it 'returns nearest available parking' do
        get :nearest, params: params

        expect(response).to be_ok

        json = JSON.parse(response.body)
        expect(json.length).to be > 0
      end

      it 'returns paginated results' do
        get :nearest, params: params.merge(page: 1, per_page: 10)

        expect(response).to be_ok

        json = JSON.parse(response.body)
        expect(json.length).to be 10
      end

      it 'returns in order of distance' do
        get :nearest, params: params.merge(page: 1, per_page: 10)

        expect(response).to be_ok

        json = JSON.parse(response.body)
        expect(json.length).to be 10

        json.each_with_index do |item, index|
          next if index == json.length - 1
          p item
          expect(item['distance']).to be < json[index + 1]['distance']
        end
      end
    end
  end
end
