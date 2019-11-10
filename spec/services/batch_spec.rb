require 'rails_helper'

RSpec.describe Batch do
  subject {Batch}

  describe '#initialize' do
    it 'assigns instance variable @size' do
      object = subject.new(5)

      expect(object.instance_variable_get(:@size)).to eq(5)
    end

    it 'assigns instance variable @items' do
      object = subject.new(5)

      expect(object.instance_variable_get(:@items)).to eq([])
    end
  end

  describe '#add' do
    context 'when full' do
      it 'raises BatchFullError' do
        object = subject.new(5)

        5.times do |index|
          object.add(index)
        end

        expect { object.add(0)}.to raise_error {BatchFullError}
      end
    end

    context 'when not full' do
      it 'adds item to batch' do
        object = subject.new(5)

        3.times do |index|
          object.add(index)
        end

        expect(object.items.count).to eq(3)
        object.add(0)
        expect(object.items.count).to eq(4)
      end
    end
  end

  describe '#full?' do
    context 'when full' do
      it 'returns true' do
        object = subject.new(5)

        5.times do |index|
          object.add(index)
        end

        expect(object.full?).to be_truthy
      end
    end

    context 'when not full' do
      it 'returns false' do
        object = subject.new(5)
        4.times do |index|
          object.add(index)
        end

        expect(object.full?).to be_falsey
      end
    end
  end
end