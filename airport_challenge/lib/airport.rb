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
    plane.land(self)
    add_plane_to_hangar(plane)
  end

  def take_off(plane)
    raise "Cannot take off. Weather is stormy" if stormy?
    raise "No such plane at this airport" if !at_airport? plane
    plane.take_off
    remove_plane_from_hangar(plane)
  end

private

  attr_reader :weather

  def full?
    hangar.count == capacity
  end

  def stormy?
    weather.stormy?
  end

  def at_airport?(plane)
    hangar.include? plane
  end

  def add_plane_to_hangar(plane)
    hangar << plane
  end

  def remove_plane_from_hangar(plane)
    hangar.delete(plane)
  end

end
