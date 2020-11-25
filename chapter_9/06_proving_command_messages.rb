require 'minitest/autorun'

class Gear
	attr_reader :chainring, :cog, :wheel, :observer

	def initialize(args)
		@chainring = args[:chainring]
		@cog = args[:cog]
		@observer = args[:observer]
	end

	def set_cog(new_cog)
    @cog = new_cog
    changed
	end

	def set_chainring(new_chainring)
    @chainring = new_chainring
    changed
	end

	def changed
		observer.changed(chainring, cog)
	end
end

class GearTest < Minitest::Test
	def setup
		@observer = Minitest::Mock.new
		@gear = Gear.new(chainring: 52, cog: 11, observer: @observer)
	end

	def test_notifies_observers_when_cog_changes
		@observer.expect(:changed, true, [52, 27])
		@gear.set_cog(27)
		@observer.verify
	end

	def test_notifies_observers_when_chainring_changes
		@observer.expect(:changed, true, [42, 11])
		@gear.set_chainring(42)
		@observer.verify
	end
end

=begin
## Testing Private Methods

### Ignoring Private Methods During Tests

  Objects send messages to self, which invokes methods in its private interface.
Those methods should not be tested and there are excellent reasons for it.

**Redundancy**: private methods are invoked by public methods that already have
tests. A broken private method will lead to an error in the public method test.
They don't need a test of their own.

**Instability**: the private interface is the unstable portion of the object,
testing it couples your code to code that is high likely to change. Maintaining
these tests is a waste of time with unnecessary tests.

## Testing Outgoing Messages

  Outgoing messages can be either: queries (matter only to the object that sends
them), or commands (have effects that are visible to other objects in the
application).

### Ignoring Query Messages

class Gear
	# [...]

	def gear_inches
		ratio * wheel.diameter
	end
end

  Query messages have no side effects. Nothing in the application other than
gear_inches cares if diameter gets sent. It does not leave any trails and no
other object depends on its execution.

  Objects should therefore ignore outgoing query messages. The diameter method
test belongs to the Wheel test class.

Testing it in Gear would just duplicate that responsibility and raise maintenance
costs.

## Proving Command Messages

  Sometimes however, it does matter that a message gets sent, other parts of your
application depend on something that happens as a result.

  Whenever a player changes a gear, the application has to be notified in order
to update the Bicycle behavior. Gear does that through the observer object in the
changed method. Once a player changes gears, the application will be correct only
if Gear is successful on sending changed to observer. Gear tests should prove
this message gets sent.

  You need to check if the message gets sent, not the result it returns. The
result of the observer's changed method should reside in the observer test and
should not be duplicated.

  To test that a message gets sent, we use a mock. `Mocks` are tests of behavior,
not tests of state. Instead of making assertions about what a message returns,
mocks define an expectation that a message will get sent.

  Whenever a player changes a gear, the application has to be notified in order
to update the Bicycle behavior. Gear does that through the observer object in the
changed method. Once a player changes gears, the application will be correct only
if Gear is successful on sending changed to observer. Gear tests should prove
this message gets sent.

  You need to check if the message gets sent, not the result it returns. The
result of the observer's changed method should reside in the observer test and
should not be duplicated.

  To test that a message gets sent, we use a mock. `Mocks` are tests of behavior,
not tests of state. Instead of making assertions about what a message returns,
mocks define an expectation that a message will get sent.
=end
