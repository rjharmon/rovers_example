class Rover
  attr_accessor :position
  attr_accessor :direction

  def initialize(x,y,direction)
    @position = [ x, y ]
    @direction = direction
  end
end

