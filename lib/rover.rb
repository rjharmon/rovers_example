class Rover
  class BadDirection < Exception ; end
  class Lost < Exception ; end

  attr_accessor :position
  attr_accessor :heading

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

  HEADINGS = [ N, E, S, W ]
  RIGHT = 1  # -> thataway
  LEFT = -1  # <- thataway
  TURNS = {
    L => LEFT,
    R => RIGHT
  }
  def initialize(plateau, x,y,heading)
    @position = [ x, y ]
    @plateau = plateau
    @heading = heading
  end

  def to_s
    [ @position, @heading ].flatten.join(" ")
  end
  
  def move
    direction = OFFSETS[heading]
    new_x = guard_move(@position.first, direction.first, @plateau.width)
    new_y = guard_move(@position.last, direction.last, @plateau.height)

    @position = [ new_x, new_y ]
  end

  def guard_move(current_pos, offset, limit)
    new_pos = current_pos + offset

    raise lost_exception if new_pos < 0 or new_pos >= limit
    new_pos
  end
  protected :guard_move

  def lost_exception
    Lost.new("at "+ self.to_s)
  end
  protected :lost_exception

  def turn(direction)
    self.heading = new_heading(direction)
  end

  def new_heading(direction)
    current_index = HEADINGS.index(self.heading)
    turn_direction = TURNS[direction] || raise(BadDirection, "Can't turn #{direction} from #{self.heading}")
    
    new_index = current_index + turn_direction
    new_index = 3 if new_index < 0
    new_index = 0 if new_index > 3

    HEADINGS[new_index]
  end
  protected :new_heading

end

