require 'minitest/autorun'

class Gear
	attr_reader :chainring, :cog, :wheel

	def initialize(args)
		@chainring = args[:chainring]
		@cog = args[:cog]
		@wheel = args[:wheel]
	end

	def gear_inches
		ratio * wheel.diameter # Wheel plays the virtual Diameterizable role
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
  Not being able to test the Gear class in isolation, reveals that it is bound
to an specific context, one that will interfere with reuse. Chapter 3 solve this
coupling issue by removing the creating of Wheel from Gear class and injecting
the dependency instead.

  The diameter method is now part of the public interface of a role, the
Diameterizable role.

  The invisible coupling between Wheel and Gear has been publicly exposed in both
the application and tests.
=end
