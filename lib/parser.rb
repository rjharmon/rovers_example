class Parser
  attr_accessor :height, :width

  def read(input)
    case state
      when /plateau/
        if input =~ /(\d+)\s+(\d+)/
          @height, @width = $1.to_i, $2.to_i
          @plateau = Plateau.new(@height, @width)
          @state = "waiting for rover"
        else
          # TODO: error reporting
        end
      when /rover/
        if input =~ /(\d+)\s+(\d+)\s+([NSEW])/
          x, y, direction = $1.to_i, $2.to_i, $3
          @current_rover = Rover.new(x, y, direction)
        else
          # TODO error reporting
        end
    end
  end

protected
  def state
    @state ||= "waiting for plateau size"
  end
end