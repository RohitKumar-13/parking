require 'rails_helper'

module CarParkingMigrator
  RSpec.describe Base do
    subject {CarParkingMigrator::Base}

    describe '#initialize' do
      it 'assigns instance variable @path' do
        path = file_fixture("carpark.csv").to_s
        object = subject.new(path)

        expect(object.path).to eq(path)
      end

      it 'assigns instance variable @batches' do
        path = file_fixture("carpark.csv").to_s
        object = subject.new(path)

        expect(object.batches).to be_instance_of(Array)
        expect(object.batches).to be_empty
      end
    end

    describe '#run!' do
      before {
        body = {latitude: rand(1.1496..1.4784001), longitude: rand(103.594..104.0945001)}
        allow(HTTParty).to receive(:get).with('https://developers.onemap.sg/commonapi/convert/3414to4326', any_args)
                             .and_return(OpenStruct.new(parsed_response: body.as_json))
      }

      context 'when file is invalid' do
        it 'raises invalid file error' do
          path = file_fixture("carpark.csv").to_s
          object = subject.new(path + 'x')

          expect{object.run!}.to raise_error{FileExtensionError}
        end
      end

      context 'when file is valid' do
        it 'adds entries to CarParking' do
          path = file_fixture("carpark.csv").to_s
          object = subject.new(path)

          object.run!

          expect(CarParking.count).to be(5)
        end
      end
    end
  end
end