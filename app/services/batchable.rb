module Batchable
  BATCH_SIZE = 1000

  def self.included(base)
    base.send(:attr_accessor, :batches)
  end

  def find_or_create_batch
    if self.batches.nil?
      self.batches = Array.new
    end
    if self.batches.blank? || self.batches.last.full?
      self.batches.push(Batch.new(BATCH_SIZE))
    end
    self.batches.last
  end
end