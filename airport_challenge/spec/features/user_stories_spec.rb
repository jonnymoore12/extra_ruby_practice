describe 'User Stories' do
  let(:airport) { Airport.new(10, weather) }
  let(:plane) { Plane.new }
  let(:weather) { Weather.new }

  context 'when not stormy' do
    before do
      allow(weather).to receive(:stormy?).and_return false
    end
    # As an air traffic controller
    # So I can get passengers to a destination
    # I want to instruct a plane to land at an airport
    it 'so planes land at airports, instruct a plane to land' do
      expect { airport.land(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # So I can get passengers on the way to their destination
    # I want to instruct a plane to take off from an airport
    it 'so planes take off from an airport, instruct a plane to take off' do
      airport.land(plane)
      expect { airport.take_off(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # So I can ensure safe take off procedures
    # I want planes to only take off from airports at which they are at
    it 'planes can only take off from airports at which they are at' do
      expect { airport.take_off(plane) }.to raise_error "No such plane at this airport"
    end

    # As the systems designer
    # So that the software can be used by many different airports
    # I would like a default airport capacity that can be overridden.
    it 'airports have a default capacity of 10' do
      expect(airport.capacity).to eq 10
    end

    # As an air traffic controller
    # So the system is consistent and correctly reports plane status
    # I want to ensure a flying plane cannot take off from or be in an airport
    it 'flying planes cannot take off' do
      airport.land(plane)
      flying_plane = airport.take_off(plane)
      expect { flying_plane.take_off }.to raise_error "Cannot take off. Plane already flying"
    end

    it 'flying planes cannot be at an airport' do
      airport.land(plane)
      flying_plane = airport.take_off(plane)
      expect { flying_plane.airport }.to raise_error "Plane cannot be at an airport. Plane already flying"
    end

    # As an air traffic controller
    # So the stystem is consistent and correctly reports plane status and location
    # I want to ensure that a plane that is not flying cannnot land and must not be in an airport.
    it 'non-flying planes cannot land' do
      airport.land(plane)
      expect { plane.land(airport) }.to raise_error "Plane has already landed and cannot land"
    end

    it 'non-flying planes must be in an airport' do
      airport.land(plane)
      expect(plane.airport).to eq airport
    end

    # As an air traffic controller
    # So they system is consistent and correctly reports plane status
    # I want to ensure that a plane that has taken off from an airport is no longer in an airport
    it 'taking off a plane removes it from that airport' do
      airport.land(plane)
      airport.take_off(plane)
      expect(airport.hangar).not_to include plane
    end

    # As an air traffic controller
    # To ensure safety
    # I want to prevent landing when the airport is full
    context 'when airport is full' do
      it 'raises an error when trying to land a plane' do
        Airport::DEFAULT_CAPACITY.times do
          airport.land(Plane.new)
        end
        expect { airport.land(plane) }.to raise_error "Cannot land plane. Airport already at full capacity"
      end
    end
  end

  context 'when stormy' do
    before do
      allow(weather).to receive(:stormy?).and_return true
    end
    # As an air traffic controller
    # To ensure safety
    # I want to prevent landing when weather is stormy
    it 'does not allow planes to land' do
      expect { airport.land(plane) }.to raise_error "Cannot land plane. Weather is stormy"
    end
    # As an air traffic controller
    # To ensure safety
    # I want to prevent takeoff when weather is stormy
    it 'does not allow planes to take off' do
      expect { airport.take_off(plane) }.to raise_error "Cannot take off. Weather is stormy"
    end
  end

end
