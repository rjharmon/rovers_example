require "rspec"

describe "parsing input" do
  before do
    @p = Parser.new
  end
  it "initializes the plateau" do
    Plateau.should_receive(:new).with(6,5)
    @p.read("6 5")
  end
end