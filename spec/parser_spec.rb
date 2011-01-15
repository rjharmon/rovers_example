require "rspec"

describe "parsing input" do
  before do
    @p = Parser.new
  end
  it "initializes the plateau" do
    Plateau.should_receive(:new).with(6,5)
    @p.read("6 5")
  end
  describe "contacting the rovers" do
    before do
      @p.read("6 5")
    end
    it "should create a rover in the right initial position" do
      Rover.should_receive(:new).with(3, 2, "E")
      @p.read("3 2 E")
    end

  end
  
end