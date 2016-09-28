class Plane

  def initialize
    @flying = true
    @airport = nil
  end


  def take_off
    raise "Cannot take off. Plane already flying" if flying?
    @flying = true
  end

  def airport
    raise "Plane cannot be at an airport. Plane already flying" if flying?
    @airport
  end

  def land(airport)
    raise "Plane has already landed and cannot land" unless flying?
    @airport = airport
    @flying = false
  end

  private

  def flying?
    @flying == true
  end

end
