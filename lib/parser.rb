class Parser
  attr_accessor :height, :width

  def read(input)
    case state
      when /plateau/
        if input =~ /(\d+)\s+(\d+)/
          @height, @width = $1.to_i, $2.to_i
          @plateau = Plateau.new(@height, @width)
        else
          # TODO: error handling
        end
    end
  end

protected
  def state
    @state ||= "waiting for plateau size"
  end
end