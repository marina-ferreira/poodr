require 'minitest/autorun'

class Gear
	attr_reader :chainring, :cog, :wheel

	def initialize(args)
		@chainring = args[:chainring]
		@cog = args[:cog]
		@wheel = args[:wheel]
	end

	def gear_inches
		ratio * wheel.diameter
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

class WheelTest < Minitest::Test
	def setup
		@wheel = Wheel.new(26, 1.5)
	end

	def test_implements_diameteriable_interface
		assert_respond_to(@wheel, :diameter)
	end

	def test_implements_diameteriable_interface
		wheel = Wheel.new(26, 1.5)
		assert_in_delta(29, wheel.diameter, 0.01)
	end
end

=begin
	Since the Diameterizable role is virtual and there is no place expecting that
role, it's only comprehensible to forget that a test double plays that role.
The code above raises the role visibility by asserting Wheel plays it. Although
this may seem like a solution, it's quite incomplete. There is no way to share
this test, other players would have to duplicate the test. It still does not
assure that a double playing the role won't get obsolete. The best choice for
testing roles will be discussed in the Duck Type section of this chapter.
=end
