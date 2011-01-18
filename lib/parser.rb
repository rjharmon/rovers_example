class Parser
  class BadInputError < Exception ; end
  attr_accessor :pleateau

  def read(input)
    @line ||= 0
    @line += 1
    case state
      when /plateau/
        if input =~ /^\s*(\d+)\s+(\d+)\s*$/
          @height, @width = $1.to_i, $2.to_i
          @state = "waiting for rover"
          @plateau = Plateau.new(@height, @width)
        else
          raise BadInputError, "bad formatting on line #{@line}.  Required: X Y (integer sizes of plateau)"
        end
      when /rover/
        if input =~ /^\s*(\d+)\s+(\d+)\s+([NSEW])\s*$/i
          x, y, direction = $1.to_i, $2.to_i, $3
          @state = "waiting for commands"

          @current_rover = Rover.new(@plateau, x, y, direction)
        else
          raise BadInputError, "bad formatting on line #{@line}.  Required: X Y D (location and direction [NSEW] of rover)"
        end
      when /waiting for commands/
        input.each_char do |command|
          case command
            when 'M'
              @current_rover.move
            when 'L', 'R'
              direction = command
              @current_rover.turn(direction)
          end
        end
        @state = 'waiting for rover'
    end
  end

  def state
    @state ||= "waiting for plateau size"
  end
end