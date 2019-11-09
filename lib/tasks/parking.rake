namespace :parking do
  namespace :load do
    task csv: :environment do
      puts 'car parking data migration started'
      CarParkingMigrator.migrate('config/data/hdb-carpark-information.csv')
      puts 'car parking data migration completed'
    end

    task availability: :environment do
      puts 'Availability data migration started'
      ParkingAvailabilityMigrator.migrate
      puts 'Availability data migration completed'
    end
  end
end
