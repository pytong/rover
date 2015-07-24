class Rover

  attr_reader :orientation
  attr_reader :x
  attr_reader :y

  def initialize(attrs = {})
    @orientation = attrs[:orientation].to_sym
    @x = attrs[:x].to_i
    @y = attrs[:y].to_i
  end

  def move
    case @orientation
    when Orientation.east
      @x += 1
    when Orientation.west
      @x -= 1
    when Orientation.north
      @y += 1
    when Orientation.south
      @y -= 1
    end
  end

  def spin(operation)
    rotate_by = (operation == Operation.left ? -1 : 1)
    current_orientation_index = Orientation.all.index(@orientation)

    @orientation = Orientation.all.rotate(current_orientation_index).rotate(rotate_by)[0]
  end

end