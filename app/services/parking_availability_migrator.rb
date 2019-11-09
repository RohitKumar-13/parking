module ParkingAvailabilityMigrator
  def self.migrate
    Base.new.run!
  end
end