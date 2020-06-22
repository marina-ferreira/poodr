# Bad 🤢
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * diameter
  end

  def diameter # Wheel like behavior
    rim + tire * 2
  end
end

# Good 😻
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do
    def diameter
      rim + tire * 2
    end
  end
end

# Once isolated it's also easier to move it to a class of its own when the time comes. Isolation allows change without consequence and reuse without duplication.

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel = nil)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
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

  def circunference
    diameter * Math::PI
  end
end

@wheel = Wheel.new(26, 1.5)
gear_inches = Gear.new(52, 11, @wheel).gear_inches
ratio = Gear.new(52, 11).ratio

print("gear_inches: #{gear_inches}, ratio: #{ratio}")
