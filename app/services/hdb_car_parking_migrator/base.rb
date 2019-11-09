module HdbCarParkingMigrator
  class Base
    attr_reader :path, :batches

    BATCH_SIZE = 10

    def initialize(path)
      @path = path
      @batches = Array.new
    end

    def run!
      validate_file!

      CSV.foreach(path, headers: true) do |row|
        batch = find_or_create_batch
        row['x_coord'], row['y_coord'] = svy21_to_wgs84(row['x_coord'], row['y_coord'])
        batch.add(row.to_h.merge!({created_at: Time.now, updated_at: Time.now}))
      end

      save!
    end

    private

    def validate_file!
      unless File.extname(path).eql?('.csv')
        raise FileExtensionError.new(I18n.t('hdb_car_parking_migrator.errors.file_extension_error'))
      end
    end

    def find_or_create_batch
      batch = batches.last
      if batch.nil? || batch.full?
        batch = Batch.new(BATCH_SIZE)
      end
      batch
    end

    def svy21_to_wgs84(x, y)
      body = Svy21ToWgs84Converter.convert(x, y)
      [body['latitude'], body['longitude']]
    end

    def save!
      HdbCarParking.delete_all
      batches.each do |batch|
        HdbCarParking.insert_all(batch.items)
      end
    end
  end
end