require "rspec"

describe "parsing input" do
  before do
    @p = Parser.new
  end

  describe "- plateau definition" do
    before do
    end
    it "causes the Plateau to be created" do
      Plateau.should_receive(:new).with(6,5)
      @p.read("6 5")
    end

    it "goes into waiting-for-rover state" do
      @p.read("6 5")
      @p.state.should =~ /rover/
    end

    describe "- acceptable formatting discrepancies:" do
      {
        "  1 2" => "leading spaces",
        "1 2   " => "trailing spaces",
        "1   2" => "internal spaces",
      }.each do |example, description|
        it (description) do
          lambda {
            @p.read(example)
          }.should_not raise_error(Parser::BadInputError)
        end
      end
    end

    describe "error:" do
      {
        "1" => "not enough integers",
        "1 2 3" => "too many integers",
        "1 A 3" => "non-integers (A in the middle)",
        "1 ; 3" => "non-integers (; in the middle)",
        "1 3 A" => "non-integers (A in the end)",
        "? A 3" => "non-integers (? at the beginning)",
      }.each do |example, description|
        it (description) do
          lambda {
            @p.read(example)
          }.should raise_error(/line 1/)
        end
      end
    end
  end

  describe "placing a rover" do
    before do
      @plateau = @p.read("6 5")
    end
    it "creates a rover in the right initial position" do
      Rover.should_receive(:new).with(@plateau, 3, 2, "E")
      @p.read("3 2 E")
    end
    it "goes into waiting-for-rover-commands state" do
      @p.read("3 2 E")
      @p.state.should =~ /commands/
    end
    describe "acceptable formatting discrepancies:" do
      {
        "  3 2 E" => "leading spaces",
        "3 2 E  " => "trailing spaces",
        "3  2  E" => "internal spaces",
        "3 2 e" => "lower-case"
      }.each do |example, description|
        it(description) do
          lambda {
            @p.read(example)
          }.should_not raise_error
        end
      end
    end
  end

  describe "moving the current rover" do
    before do
      @plateau = @p.read("6 5")
      @rover = @p.read("3 2 E")
    end
    it "tells the rover to move and turn as requested" do
      @rover.should_receive(:move)
      @rover.should_receive(:turn).with("L")
      @rover.should_receive(:move)
      @p.read("MLM")
    end
    it "goes into waiting-for-rover state" do
      @p.read("3 2 E")
      @p.state.should =~ /rover/
    end
  end

end