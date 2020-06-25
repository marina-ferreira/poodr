# Bad 🤢
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire) # Wheel creation has been exposed in the
                                  # initialize method, but this unconditionally
                                  # creates a new wheel each time Gear is created
  end

  def gear_inches
    ratio * wheel.diameter
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
    ratio * wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
end

=begin
  The creation of Wheel has now been isolated in its own wheel method and the
  Wheel instance is now lazily created. It's creation is deferred until
  gear_inches invokes it. Although Gear still knows far too much, dependencies
  are now publicly exposed and now the class is more reusable and allows
  refactoring when needed.
=end
