require "rspec"

describe Rover do
  N = "N"
  S = "S"
  E = "E"
  W = "W"
  L = "L"
  R = "R"
  before do
    @plateau = Plateau.new(10,10)
    @r = Rover.new(@plateau, 5,5,E)
  end
  describe "initialization" do
    it "has the right position" do
      pos = @r.position
      pos.should == [5, 5]
    end
    it "has the right direction" do
      @r.direction.should == E
    end
  end

  describe "move" do
    it "goes to the right location" do
      @r.move
      @r.position.should == [6, 5]
    end
    it "doesn't change direction" do
      @r.move
      @r.direction.should == E
    end
    describe "different directions" do
      def go(direction)
        @r.direction = direction
        @r.move
      end
      it "should go north" do
        go(N)
        @r.position.should == [5,6]
      end
      it "should go east" do
        go(E)
        @r.position.should == [6,5]
      end
      it "should go south" do
        go(S)
        @r.position.should == [5,4]
      end
      it "should go west" do
        go(W)
        @r.position.should == [4,5]
      end
    end
  end

  describe "turn" do
    def should_turn(turn, directions = {})
      from_dir = directions.keys.first || raise( ArgumentError, "one key-value for direction")
      to_dir = directions[from_dir]

      @r.direction = from_dir
      @r.turn(turn)
      @r.direction.should == to_dir
    end
    describe "error" do
      it "raises exception for bad directions" do
        lambda { @r.turn("Q") }.should raise_error(Rover::BadDirection)
      end
    end
    describe "left" do
      it "goes from N to W" do
        should_turn(L, N => W)
      end
      it "goes from W to S" do
        should_turn(L, W => S)
      end
      it "goes from S to E" do
        should_turn(L, S => E)
      end
      it "goes from E to N" do
        should_turn(L, E => N)
      end
    end
    describe "right" do
      it "goes from S to W" do
        should_turn(R, S => W)
      end
      it "goes from E to S" do
        should_turn(R, E => S)
      end
      it "goes from N to E" do
        should_turn(R, N => E)
      end
      it "goes from W to N" do
        should_turn(R, W => N)
      end
    end
  end
end



