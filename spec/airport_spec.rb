require 'airport'

describe Airport do
  subject(:airport) { described_class.new(10, weather) }
  let(:plane) { double :plane }
  let(:weather) { double :weather }

  it 'is initialized with a default capacity of 10' do
    expect(airport.capacity).to eq 10
  end

  it 'airport capacity can be manually set on instantiation' do
    heathrow = Airport.new(20, weather)
    expect(heathrow.capacity).to eq 20
  end

  describe '#land' do
    context 'when not stormy' do
      before do
        allow(weather).to receive(:stormy?).and_return false
      end

      it 'instructs a plane to land' do
        expect(airport).to respond_to(:land).with(1).argument
      end

      it 'landed planes are stored in the airport hangar' do
        airport.land(plane)
        expect(airport.hangar).to include plane
      end

      context 'when full' do
        it 'raises an error if we try to land a plane' do
          Airport::DEFAULT_CAPACITY.times do
            airport.land(plane)
          end
          expect { airport.land(plane) }.to raise_error "Cannot land plane. Airport already at full capacity"
        end
      end
    end

    context 'when stormy' do
      it 'raises an error' do
        allow(weather).to receive(:stormy?).and_return true
        expect { airport.land(plane) }.to raise_error "Cannot land plane. Weather is stormy"
      end
    end

  end

  describe '#take_off' do
    context 'not stormy' do
      before do
        allow(weather).to receive(:stormy?).and_return false
      end

      it 'instructs a plane to take off' do
        expect(airport).to respond_to(:take_off).with(1).argument
      end

      it 'removes planes from the airport hangar' do
        airport.land(plane)
        airport.take_off(plane)
        expect(airport.hangar).not_to include plane
      end

      it 'raises an error if plane is not in airport hangar' do
        expect { airport.take_off(plane) }.to raise_error "No such plane at this airport"
      end
    end

    context 'when stormy' do
      it 'raises an error' do
        allow(weather).to receive(:stormy?).and_return true
        expect { airport.take_off(plane) }.to raise_error "Cannot take off. Weather is stormy"
      end
    end

  end

end
