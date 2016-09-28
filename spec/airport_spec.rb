require 'airport'

describe Airport do
  subject(:airport) { described_class.new }
  let(:plane) { double :plane }

  it 'is initialized with a default capacity of 10' do
    expect(airport.capacity).to eq 10
  end

  it 'instructs a plane to land' do
    expect(airport).to respond_to(:land).with(1).argument
  end

  it 'instructs a plane to take off' do
    expect(airport).to respond_to(:take_off).with(1).argument
  end

  it 'raises an error if we try to land a plane at full airport' do
    10.times do
      airport.land(plane)
    end
    expect { airport.land(plane) }.to raise_error "Cannot land plane. Airport already at full capacity"
  end
end
