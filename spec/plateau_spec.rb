require "rspec"

describe "initialization" do
  it "should be the right size" do
    p = Plateau.new(6,5)
    p.width.should == 6
    p.height.should == 5
  end
end