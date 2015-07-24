class CommandProcessor
  attr_reader :max_x
  attr_reader :max_y

  def initialize(attrs = {})
    instructions = attrs[:commands].split("\n")
    set_max_coordinates(instructions.shift)
    @commands = instructions
  end

  def set_max_coordinates(line)
    @max_x, @max_y = line.split(" ").map(&:to_i)
  end

  def move_allowed?(rover)
    case rover.orientation
    when Orientation.east
      rover.x < @max_x
    when Orientation.south
      rover.y > 0
    when Orientation.west
      rover.x > 0
    when Orientation.north
      rover.y < @max_y
    end
  end

  def execute_instruction(lines)
    coordinates_and_orientation, instructions = lines.split("\n")
    x, y, orientation = coordinates_and_orientation.split(" ")

    rover = Rover.new({x: x, y: y, orientation: orientation})

    instructions.split("").each do |instruction|
      case instruction.to_sym
      when Operation.left
        rover.spin(Operation.left)
      when Operation.right
        rover.spin(Operation.right)
      when Operation.move
        rover.move if move_allowed?(rover)
      end
    end

    "#{rover.x} #{rover.y} #{rover.orientation}"
  end

  def execute
    result = ""
    instructions = @commands

    while !instructions.empty? do
      instruction = "#{instructions.shift}\n"
      instruction << instructions.shift
      result << "#{execute_instruction(instruction)}\n"
    end

    result
  end
end