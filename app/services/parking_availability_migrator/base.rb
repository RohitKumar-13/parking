module ParkingAvailabilityMigrator
  class Base
    include Batchable

    attr_accessor :availability

    def run!
      fetch do
        save!
      end
    end

    private

    def fetch
      self.availability = AvailabilityApi.fetch
      yield
    end

    def save!
      availability.each do |parking|
        next if parking.total_lots.to_i.zero?
        batch = find_or_create_batch
        batch.add(parking.to_h.merge!({created_at: Time.now, updated_at: Time.now}))
      end
      ParkingLot.connection.execute("TRUNCATE TABLE #{ParkingLot.table_name}")
      batches.each do |batch|
        ParkingLot.insert_all(batch.items)
      end
      true
    end
  end
end