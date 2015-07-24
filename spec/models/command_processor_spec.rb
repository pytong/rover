require_relative "../spec_helper"
require_relative "../../app/models/rover"
require_relative "../../app/models/operation"
require_relative "../../app/models/orientation"
require_relative "../../app/models/command_processor"

describe "CommandProcessor" do

  describe "set_max_coordinates" do
    subject(:command_processor) { CommandProcessor.new({commands: "5 5"}) }

    its(:max_x) { should eq(5) }
    its(:max_y) { should eq(5)}
  end

  describe "self.valid_move?" do
    context "invaid move to East" do
      let(:lines) { "3 3" }
      let(:rover) { Rover.new({x: 3, y: 2, orientation: Orientation.east}) }

      subject(:command_processor) { CommandProcessor.new({commands: lines}) }

      it "should return false" do
        expect(command_processor.move_allowed?(rover)).to eq(false)
      end
    end

    context "invalid move to South" do
      let(:lines) { "3 3" }
      let(:rover) { Rover.new({x: 2, y: 0, orientation: Orientation.south}) }

      subject(:command_processor) { CommandProcessor.new({commands: lines}) }

      it "should return false" do
        expect(command_processor.move_allowed?(rover)).to eq(false)
      end
    end

    context "invalid move to West" do
      let(:lines) { "3 3" }
      let(:rover) { Rover.new({x: 0, y: 1, orientation: Orientation.west}) }

      subject(:command_processor) { CommandProcessor.new({commands: lines}) }

      it "should return false" do
        expect(command_processor.move_allowed?(rover)).to eq(false)
      end
    end

    context "invalid move to North" do
      let(:lines) { "3 3" }
      let(:rover) { Rover.new({x: 2, y: 3, orientation: Orientation.north}) }

      subject(:command_processor) { CommandProcessor.new({commands: lines}) }

      it "should return false" do
        expect(command_processor.move_allowed?(rover)).to eq(false)
      end
    end
  end

  describe "execute_instruction" do
    let(:lines) { "3 3\n1 2 N\nLMLMLMLMM" }

    subject(:command_processor) { CommandProcessor.new({commands: lines}) }

    it "should return final rover coordinates and orientation" do
      expect(command_processor.execute_instruction("1 2 N\nLMLMLMLMM")).to eq("1 3 N")
    end
  end

  describe "execute" do
    let(:lines) { "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }

    subject(:command_processor) { CommandProcessor.new({commands: lines}) }

    it "should return final rover coordinates and orientation for all rovers" do
      expect(command_processor.execute).to eq("1 3 N\n5 1 E\n")
    end
  end
end