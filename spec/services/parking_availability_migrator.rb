require 'rails_helper'

RSpec.describe ParkingAvailabilityMigrator do
  subject {ParkingAvailabilityMigrator}

  describe '.migrate' do
    it 'runs Base migrator' do
      expect_any_instance_of(ParkingAvailabilityMigrator::Base).to receive(:run!)

      subject.migrate
    end
  end
end