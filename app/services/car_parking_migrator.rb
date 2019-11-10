module CarParkingMigrator
  def self.migrate(path)
    Base.new(path).run!
  end
end