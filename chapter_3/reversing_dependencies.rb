# Dependencies always have a direction. Instead of having Gear depending on Wheel
# and diameter, the dependency could have been inversed, having Wheel depending
# on Gear and gear_inches.

class Gear
  attr_reader :chainring, :cog

  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def gear_inches(diameter)
    ratio * diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire, :gear

  def initialize(rim, tire, gear)
    @rim = rim
    @tire = tire
    @gear = gear
  end

  def diameter
    rim + tire * 2
  end

  def gear_inches
    gear.gear_inches(diameter)
  end
end

=begin
Classes should depend on things that change less often than they do. Some
classes are more likely than other to have change in requirements. *Concrete*
classes are more likely to change than *abstract* ones. Changing a class that
has many dependents will result in widespread consequences.

Classes can be ranked along a scale of how likely it is to undergo a change
relative to all other classes, that helps deciding the direction of the
dependencies.

Classes vary in their:
  a) likelihood of change
  b) level of abstraction
  c) number of dependents
=end
