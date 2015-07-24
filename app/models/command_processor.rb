class CommandProcessor
  attr_reader :max_x
  attr_reader :max_y

  def set_max_coordinates(line)
    @max_x, @max_y = line.split(" ")
  end

  def execute_instruction(lines)
    coordinates_and_orientation, instructions = lines.split("\n")
    x, y, orientation = coordinates_and_orientation.split(" ")

    rover = Rover.new({x: x, y: y, orientation: orientation})

    instructions.split("").each do |instruction|
      case instruction.to_sym
      when Direction.left
        rover.spin(Direction.left)
      when Direction.right
        rover.spin(Direction.right)
      when :M
        rover.move
      end
    end

    "#{rover.x} #{rover.y} #{rover.orientation}"
  end

  def execute_all(lines)
    result = ""

    instructions = lines.split("\n")
    while !instructions.empty? do
      instruction = "#{instructions.shift}\n"
      instruction << instructions.shift
      result << "#{execute_instruction(instruction)}\n"
    end

    result
  end
end