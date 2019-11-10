require 'rails_helper'

RSpec.describe CarParkingMigrator do
  subject {CarParkingMigrator}

  describe '.migrate' do
    it 'runs Base migrator' do
      expect_any_instance_of(CarParkingMigrator::Base).to receive(:run!)

      subject.migrate('config/data/hdb-carpark-information.csv')
    end
  end
end