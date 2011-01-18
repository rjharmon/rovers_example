class Plateau
  attr_accessor :width, :height

  # okay, this class didn't end up pull its weight.  We could factor it out
  # but time is up.
  def initialize(max_x, max_y)
    self.width = max_x + 1
    self.height = max_y + 1
    self
  end
end