# Bad 🤢

# A message that requires arguments creates a dependency. Not only on the name
# of the arguments, but also on their order.
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
end

Gear.new(52, 11 Wheel.new(26, 1.5))

# Taking keyword arguments is a way to avoid arguments position
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring:, cog:, wheel:)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
end

Gear.new(
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(26, 1.5)
)

Gear.new(
	:cog => 11,
	:chainring => 52,
	:wheel => Wheel.new(26, 1.5)
)
