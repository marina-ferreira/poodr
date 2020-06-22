# Bad 🤢
class ObscuringReferences
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def diameter
    data.collect do |cell|
      cell[0] + cell[1] * 2 # 0 is rim, 1 is tire
    end
  end
end

# Good 😻
class RevealingReferences
  attr_reader :wheels

  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect do |wheel|
      wheel.rim + wheel.tire * 2
    end
  end

  Wheel = Struct.new(:rim, :tire)

  def wheelify(data)
     data.collect do |cell|
       Wheel.new(cell[0], cell[1])
     end
  end
end

# data is a 2d array of rims and tires
# @data = [[622, 20], [622, 23], [559, 30], [559, 40]]
