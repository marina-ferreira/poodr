# Bad 🤢
class Gear
  attr_reader :chanring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = @cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + tire * 2
  end
end

=begin
  Gear has four dependencies. Those dependencies will force Gear to change if
  Wheel ever changes, which makes the Gear class less reasonable.

    1. The name of another class. (Gear expects a class named Wheel to exist)
    2. The name of a message it intends to send to someone other than self
       (Gear expects an instance of Wheel to respond to diameter)
    3. The arguments that a message requires (Gear knows that Wheel.new requires
       rim and tire)
    4. The order of the arguments (Gear knows the first argument to Wheel.new
       should be rim, the second, tire)
=end

# Good 😻
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def gear_inches
    ratio * wheel.diameter
  end
end

Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches

=begin
  Injecting Wheel into Gear decouples the two classes. Gear does not have
  dependencies on the class type or the order of its initialization arguments
  anymore. All it knows is that the object responds to diameter. Dependencies
  have been reduced to a single one.
=end
