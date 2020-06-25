# Bad 🤢
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  # gear_inches is coupled to a message that is likely to change 🤮
  def gear_inches
    ratio * some_intermediate_result * wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
end

# Good 😻
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * some_intermediate_result * diameter
  end

  # To reduce the chance of being forced to make a change in gear_inches,
  # *wheel.diameter should be encapsulated in a method of its own. 💚
  def diameter
    wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
end

=begin
  Now the knowledge of the message sent to someone other than self lives in one
  place. A message sent to another object was replaced by a message sent to
  self (less vulnerable).
=end
