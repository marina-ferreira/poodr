require 'minitest/autorun'

class Wheel
	attr_reader :rim, :tire

	def initialize(rim, tire)
		@rim = rim
		@tire = tire
	end

	def width
		rim + (tire * 2)
	end
end

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

module DiameterizableInterfaceTest
  def test_implements_the_diameterizable_interface
    assert_respond_to(@object, :width)
  end
end

class WheelTest < Minitest::Test
  include DiameterizableInterfaceTest

  def setup
    @wheel = @object = Wheel.new(26, 1.5)
  end

  def test_implements_diameteriable_interface
    assert_in_delta(29, @wheel.width, 0.01)
  end
end

class DiameterDouble
	def diameter
		10
	end
end

class GearTest < Minitest::Test
	def test_calculates_gear_inches
		gear = Gear.new(chainring: 52, cog: 11, wheel: DiameterDouble.new)
		assert_in_delta(47.27, gear.gear_inches, 0.01)
	end
end

class DiameterDoubleTest < Minitest::Test
  include DiameterizableInterfaceTest

	def setup
    @object = DiameterDouble.new
  end
end

=begin
  In the previous section GearTest had a false positive where the test passed,
even though the stubbed method was obsolete. In this case, sharing a test in a
module in order to prove that it correctly implements a role can improve the
overall assertions of the test.

  WheelTest made an attempt to raise awareness about its implementation of the
Diameterizable interface. The test_implements_diameteriable_interface method
needs to be extracted to a module  in order to be shared.

  This module can now be reintroduced into Wheel to prove that a Diameterizable
behaves correctly and also can be used to prevent test doubles from silently
becoming obsolete.

  Now that DiameterDouble is being tested to ensure it plays the Diameterizable
role the test fails. The error explicitly points to the obsolete interface in
DiameterDouble and causes you to correct the implementation.

Failure:
DiameterDoubleTest
#test_implements_the_diameterizable_interface [chapter_9/08_using_role_tests_to_validate_doubles.rb:36]:
Expected
#<DiameterDouble:0x00007fde92a8cb90> (DiameterDouble) to respond to #width.
=end
