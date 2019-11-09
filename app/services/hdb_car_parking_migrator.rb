require 'csv'

module HdbCarParkingMigrator

  def self.migrate(path)
    Base.new(path).run!
  end
end