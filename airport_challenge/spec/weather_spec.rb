require 'weather'

describe Weather do
  let(:weather) { Weather.new }

  describe '#stormy' do
    context 'when stormy' do
      before do
        allow(Kernel).to receive(:rand).and_return 5
      end

      it 'returns true' do
        expect(weather.stormy?).to eq true
      end
    end

    context 'when not stormy' do
      before do
        allow(Kernel).to receive(:rand).and_return 1
      end

      it 'returns false if weather is stormy' do
        expect(weather.stormy?).to eq false
      end
    end
  end
end
