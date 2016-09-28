class Airport

  attr_reader :capacity

  def initialize(capacity = 10)
    @capacity = capacity
    @hangar = []
  end

  def land(plane)
    raise "Cannot land plane. Weather is stormy" if stormy?
    raise "Cannot land plane. Airport already at full capacity" if full?
    @hangar << plane
  end

  def take_off(plane)
    raise "Cannot take off. Weather is stormy" if stormy?
  end

private

  def full?
    @hangar.count == @capacity
  end

  def stormy?
    Weather.new.stormy?
  end

end
