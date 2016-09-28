class Airport

  attr_reader :capacity

  def initialize(capacity = 10)
    @capacity = capacity
    @hangar = []
  end

  def land(plane)
    raise "Cannot land plane. Airport already at full capacity" if @hangar.count == @capacity
    @hangar << plane
  end

  def take_off(plane)
  end

end
