module CarParkingMigrator
  class Base
    include Batchable

    attr_reader :path

    def initialize(path)
      @path = path
      self.batches = Array.new
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
        raise FileExtensionError.new(I18n.t('errors.file_extension_error'))
      end
    end

    def svy21_to_wgs84(x, y)
      body = Svy21ToWgs84Converter.convert(x, y)
      [body['latitude'], body['longitude']]
    end

    def save!
      CarParking.connection.execute("TRUNCATE TABLE #{CarParking.table_name}")
      batches.each do |batch|
        CarParking.insert_all(batch.items)
      end
    end
  end
end