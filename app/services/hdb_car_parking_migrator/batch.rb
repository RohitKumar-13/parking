module HdbCarParkingMigrator
  class Batch
    attr_reader :size, :items

    def initialize(size)
      @size = size
      @items = []
    end

    def add(item)
      raise BatchFullError if full?
      items << item
    end

    private

    def full?
      size == items.size
    end
  end
end