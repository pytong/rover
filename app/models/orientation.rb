class Orientation

  def self.all
    [east, south, west, north]
  end

  def self.east
    :EAST
  end

  def self.south
    :SOUTH
  end

  def self.west
    :WEST
  end

  def self.north
    :NORTH
  end
end