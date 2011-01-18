require "rspec"

describe "initialization" do
  before do
    @r = Rover.new(10,1,"E")
  end
  it "has the right position" do
    pos = @r.position

    pos.first.should == 10
    pos.last.should == 1
  end
  it "has the right direction" do
    @r.direction.should == "E"
  end
end

