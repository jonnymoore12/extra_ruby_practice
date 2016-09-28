require 'plane'

describe Plane do
  let(:plane) { described_class.new }
  let(:airport) { double :airport }

  describe '#take_off' do
    it 'lets planes take off' do
      expect(plane).to respond_to(:take_off)
    end
    it 'raises an error if plane is already flying' do
      expect { plane.take_off }.to raise_error "Cannot take off. Plane already flying"
    end
  end

  describe '#land' do
    it 'lands planes' do
      expect(plane).to respond_to(:land).with(1).argument
    end
    it 'cannot land if already landed' do
      plane.land(airport)
      expect { plane.land(airport) }.to raise_error "Plane has already landed and cannot land"
    end
  end

  describe '#airport' do
    it 'is stored on the plane' do
      expect(plane).to respond_to(:airport)
    end
    it 'raises an error if already flying' do
      expect { plane.airport }.to raise_error "Plane cannot be at an airport. Plane already flying"
    end
  end
end
