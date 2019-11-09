module CarParkingMigrator
  module Svy21ToWgs84Converter
    MAX_RETRY_LIMIT = 5

    def self.convert(x, y, retry_count = 0)
      raise RetryLimitReached if retry_count >= MAX_RETRY_LIMIT

      HTTParty.get(
        CarParkingMigrator::Constant::SVY21_TO_WGS84_URL,
        query: {X: x, Y: y}
      ).parsed_response
    rescue Errno::ECONNRESET => _ex
      sleep(1)
      convert(x, y, retry_count + 1)
    end
  end
end