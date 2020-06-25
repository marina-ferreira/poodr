# If you depend on external code, initialized by fixed order arguments,it should
# be isolated to a module, so that initialization is own by your application.

module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel

    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end

    [...]
  end
end

module GearWrapper
  def self.gear(args)
    SomeFramework::Gear.new(
      args[:chainring],
      args[:cog],
      args[:wheel]
    )
  end
end

GearWrapper.gear(
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(26, 1.5)
)

=begin
GearWrapper is a module, not a class, which implicitly suggests that its purpose
is to respond to the message gear and that you don't expect to have instances
of GearWrapper.

When the sole purpose of an object is to create instances of another class,
that object is called Factory.
=end
