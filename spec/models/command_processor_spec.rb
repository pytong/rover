require_relative "../spec_helper"
require_relative "../../app/models/rover"
require_relative "../../app/models/direction"
require_relative "../../app/models/orientation"
require_relative "../../app/models/command_processor"

describe "CommandProcessor" do

  describe "set_max_coordinates" do
    let(:line) {"5 5"}

    subject(:command_processor) { CommandProcessor.new }

    before { command_processor.set_max_coordinates(line) }

    its(:max_x) { should eq("5") }
    its(:max_y) { should eq("5")}
  end

  describe "execute_instruction" do
    let(:lines) {
      "1 2 N\nLMLMLMLMM"
    }

    subject(:command_processor) { CommandProcessor.new }

    it "should return final rover coordinates and orientation" do
      expect(command_processor.execute_instruction(lines)).to eq("1 3 N")
    end
  end

  describe "execute_all" do
    let(:lines) {
      "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"
    }

    subject(:command_processor) { CommandProcessor.new({commands: lines}) }

    it "should return final rover coordinates and orientation for all rovers" do
      expect(command_processor.execute_all).to eq("1 3 N\n5 1 E\n")
    end
  end
end