require 'minitest/autorun'

class Gear
	attr_reader :chainring, :cog, :wheel

	def initialize(args)
		@chainring = args[:chainring]
		@cog = args[:cog]
		@wheel = args[:wheel]
	end

	def gear_inches
		ratio * wheel.diameter # Renamed method hasn't been updated to width
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

	def width # Method has been renamed
		rim + (tire * 2)
	end
end

class GearTest < Minitest::Test
	def test_calculates_gear_inches
		gear = Gear.new(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5))
		assert_in_delta(137.1, gear.gear_inches, 0.01)
	end
end

=begin
	When code and tests use the same collaborating objects, tests fail when they
should.

Error:
	GearTest#test_calculates_gear_inches:
	NoMethodError: undefined method `diameter' for #<Wheel:0x00007fd745075db8 @rim=26, @tire=1.5>

	There are cases where locating and testing the abstraction will serve you better.
	The Wheel plays the Diameterizable role. What if there are hundreds of
Diameterizables, how do you choose which one to inject? What if Diameterizable is
costly to create, how do you avoid running lots of unnecessary, time consuming code?
=end
