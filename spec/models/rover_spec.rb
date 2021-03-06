require_relative "../spec_helper"
require_relative "../../app/models/rover"
require_relative "../../app/models/operation"
require_relative "../../app/models/orientation"

describe "Rover" do
  describe "Spin Left" do
    before do
      @spin_direction = Operation.left
    end

    context "current orientation is East" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.east}) }
      before { rover.spin(@spin_direction) }
      its(:orientation) { should eq(Orientation.north) }
    end

    context "current orientation is South" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.south}) }
      before { rover.spin(@spin_direction) }
      its(:orientation) { should eq(Orientation.east) }
    end

    context "current orientation is West" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.west}) }
      before { rover.spin(@spin_direction) }
      its(:orientation) { should eq(Orientation.south) }
    end

    context "current orientation is North" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.north}) }
      before { rover.spin(@spin_direction) }
      its(:orientation) { should eq(Orientation.west) }
    end
  end

  describe "Spin Right" do
    before do
      @spin_direction = Operation.right
    end

    context "current orientation is East" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.east}) }
      before { rover.spin(@spin_direction) }
      its(:orientation) { should eq(Orientation.south) }
    end

    context "current orientation is South" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.south}) }
      before { rover.spin(@spin_direction) }
      its(:orientation) { should eq(Orientation.west) }
    end

    context "current orientation is West" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.west}) }
      before { rover.spin(@spin_direction) }
      its(:orientation) { should eq(Orientation.north) }
    end

    context "current orientation is North" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.north}) }
      before { rover.spin(@spin_direction) }
      its(:orientation) { should eq(Orientation.east) }
    end
  end

  describe "Move" do
    context "current orientation is East" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.east}) }
      it "should increment x by 1" do
        expect{rover.move}.to change{rover.x}.by(1)
      end
    end

    context "current orientation is South" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.south}) }
      it "should decrement y by 1" do
        expect{rover.move}.to change{rover.y}.by(-1)
      end
    end

    context "current orientation is West" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.west}) }
      it "should decrement x by 1" do
        expect{rover.move}.to change{rover.x}.by(-1)
      end
    end

    context "current orientation is North" do
      subject(:rover) { Rover.new({x: 0, y: 0, orientation: Orientation.north}) }
      it "should increment y by 1" do
        expect{rover.move}.to change{rover.y}.by(1)
      end
    end

  end

end