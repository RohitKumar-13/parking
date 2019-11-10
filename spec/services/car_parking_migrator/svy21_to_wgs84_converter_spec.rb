require 'rails_helper'

module CarParkingMigrator
  RSpec.describe Svy21ToWgs84Converter do
    subject {CarParkingMigrator::Svy21ToWgs84Converter}
    let(:body) {{latitude: rand(1.1496..1.4784001), longitude: rand(103.594..104.0945001)}}
    before {
      allow(HTTParty).to receive(:get).with('https://developers.onemap.sg/commonapi/convert/3414to4326', any_args)
                           .and_return(OpenStruct.new(parsed_response: body.as_json))
    }

    describe '.convert' do
      context 'when no error is raised' do
        it 'returns latitude and longitude in response' do
          expect(subject.convert(23423.435345, 354532.62432)).to eq(body.as_json)
        end
      end

      context 'when error is raised' do
        it 'retries' do
          allow(HTTParty).to receive(:get).and_raise(Errno::ECONNRESET)
          expect(subject).to receive(:convert)

          subject.convert(23423.435345, 354532.62432)
        end
      end
    end
  end
end