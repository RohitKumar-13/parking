module HdbCarParkingMigrator
  class RetryLimitReached < StandardError
    attr_reader :message

    def initialize
      @message = I18n.t('hdb_car_parking_migrator.errors.retry_limit_reached')
      super
    end
  end
end