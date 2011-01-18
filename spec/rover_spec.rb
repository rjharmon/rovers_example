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
    it "has the right heading" do
      @r.heading.should == E
    end
  end

  describe "move" do

    def go(heading)
      @r.heading = heading
      @r.move
    end
    
    it "goes to the right location" do
      @r.move
      @r.position.should == [6, 5]
    end
    it "doesn't change heading" do
      @r.move
      @r.heading.should == E
    end
    describe "on different heading" do
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

    describe "off the plateau" do
      def fails(pos_x, pos_y, direction)
        @r.position = [pos_x, pos_y]
        lambda { go(direction) }.should raise_error(Rover::Lost)
      end
      it "to the north" do
        fails(1,9, N)
      end
      it "to the south" do
        fails(1,0, S)
      end
      it "to the east" do
        fails(9,1, E)
      end
      it "to the west" do
        fails(0,1, W)
      end
    end

    describe "near the edge" do
      it "doesn't have off-by-one errors" do
        @r.position = [1,8]
        go(E)
        go(N)
        @r.position = [8,1]
        go(S)
        go(W)
      end
    end

  end

  describe "turn" do
    def should_turn(turn, headings = {})
      from_hd = headings.keys.first || raise( ArgumentError, "one key-value for direction")
      to_hd = headings[from_hd]

      @r.heading = from_hd
      @r.turn(turn)
      @r.heading.should == to_hd
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



