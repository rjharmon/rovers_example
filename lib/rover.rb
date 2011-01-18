class Rover
  class BadDirection < Exception ; end

  attr_accessor :position
  attr_accessor :direction

  L = "L"
  R = "R"
  E = "E"
  W = "W"
  N = "N"
  S = "S"

  OFFSETS = {
    N => [0,1],
    S => [0,-1],
    E => [1,0],
    W => [-1,0]
  }

  DIRECTIONS = [ N, E, S, W ]
  RIGHT = 1  # -> thataway
  LEFT = -1  # <- thataway
  TURNS = {
    L => LEFT,
    R => RIGHT
  }
  def initialize(plateau, x,y,direction)
    @position = [ x, y ]
    @plateau = plateau
    @direction = direction
  end

  def move
    @position[0] += OFFSETS[direction].first
    @position[1] += OFFSETS[direction].last
  end

  def turn(direction)
    direction_index = DIRECTIONS.index(self.direction)
    direction_index += TURNS[direction] || raise(BadDirection, "Can't turn #{direction} from #{self.direction}")
    direction_index = 3 if direction_index < 0
    direction_index = 0 if direction_index > 3

    new_direction = DIRECTIONS[direction_index]
    self.direction = new_direction
  end

end

