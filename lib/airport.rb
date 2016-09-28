require_relative 'weather'

class Airport

  DEFAULT_CAPACITY = 10
  attr_reader :capacity, :hangar

  def initialize(capacity = DEFAULT_CAPACITY, weather)
    @capacity = capacity
    @weather = weather
    @hangar = []
  end

  def land(plane)
    raise "Cannot land plane. Weather is stormy" if stormy?
    raise "Cannot land plane. Airport already at full capacity" if full?
    @hangar << plane
  end

  def take_off(plane)
    raise "Cannot take off. Weather is stormy" if stormy?
    raise "No such plane at this airport" if !at_airport? plane
    @hangar.delete(plane)
  end

private

  def full?
    @hangar.count == @capacity
  end

  def stormy?
    @weather.stormy?
  end

  def at_airport?(plane)
    @hangar.include? plane
  end

end
