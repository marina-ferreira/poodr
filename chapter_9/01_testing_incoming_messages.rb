require "minitest/autorun"

class Gear
	attr_reader :chainring, :cog, :rim, :tire

	def initialize(args)
		@chainring = args[:chainring]
		@cog = args[:cog]
		@rim = args[:rim]
		@tire = args[:tire]
	end

	def gear_inches
		ratio * Wheel.new(rim, tire).diameter
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
	def test_calculates_diameter
		wheel = Wheel.new(26, 1.5)
		assert_in_delta(29, wheel.diameter, 0.01)
	end
end

class GearTest < Minitest::Test
	def test_calculates_gear_inches
		gear = Gear.new(chainring: 52, cog: 11, rim: 26, tire: 1.5)
		assert_in_delta(137.1, gear.gear_inches, 0.01)
	end
end

=begin
  In order to design cost effective tests, it's important to know what, when
and how to test the objects.
  Every design technique learnt so far should also be applied to tests, since a
test is simply another object that interacts with your classes.

  💡 Rule: objects should perform assertions about state only for messages in
    their own public interface. This dries out the tests and lowers maintenance
    costs.

There are two kinds of outgoing messages:

  1. **Queries**: outgoing messages that do not have side effects and thus matter
only to the sender. They make up the receiver public interface and their state
tests should be confined in that object test.

  2. **Commands**: outgoing messages that do have side effects, such as: a file
gets written, a database record gets saved or an action is taken by an observer.
Your application depends upon those messages, so it's the sending object
responsibility to test whether the message has been properly sent.

  Proving that a message has been sent is a test of behavior (not state) and
involves assertions about the numbers of times and with what arguments the
message is sent.

>> Guidelines

1. incoming messages should be tested for the state they return
2. outgoing command messages should be tested to ensure they get sent
3. outgoing query messages should not be tested

  The gear test may look similar to WheelTest but it has a hidden dependency.
The gear_inches method creates an instance of Wheel, which makes Wheel and Gear
tightly coupled.

That coupling affects how long your tests take to run

  If Wheel is expensive to create, the test pays for it even tough Wheel is not
its focus. If Wheel is coupled to other objects the problem is magnified.

  The coupling also creates unintended consequences as a result of changes to
unrelated parts of the application. If Gear is correct but Wheel is broken, the
Gear test might fail in a misleading way, at a place for distant from the code
you are trying to test.

Although the GearTest correctly passes, there are several issues in the Gear
class not made explicit by the test.
=end
