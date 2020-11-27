require 'minitest/autorun'

class Mechanic
	def prepare_trip
		trip.bicycles.each do |bicycle|
			prepare_bicycle(bicycle)
		end
	end
end

class TripCoordinator
	def prepare_trip(trip)
		buy_food(trip.customers)
	end
end

class Trip
	attr_reader :bicycles, :customers, :vehicle

	def prepare(prepares)
		prepares.each do |preparer|
			preparer.prepare_trip(self)
		end
	end
end

class Driver
	def prepare_trip(trip)
		vehicle = trip.vehicle
		gas_up(vehicle)
		fill_water_tank(vehicle)
	end
end

module PreparerInterfaceTest
	def test_implements_the_preparer_interface
		assert_respond_to(@object, :prepare_trip)
	end
end

class MechanicTest < Minitest::Test
	include PreparerInterfaceTest

	def setup
		@mechanic = @object = Mechanic.new
	end
end

class TripTest < Minitest::Test
	def test_requests_trip_preparations
		@preparer = Minitest::Mock.new
		@trip = Trip.new
		@preparer.expect(:prepare_trip, nil, [@trip])
		@trip.prepare([@preparer])
		@preparer.verify
	end
end

=begin
  We've seen the issues with testing roles in the previous sections but haven't
found the best way to deal with it. In chapter 5 Mechanic, TripCoordinator and
Driver played the Preparer role.

  The above code contains a collaboration between Preparers and a Trip, which can
be thought of as a Preparable. The test should document the existence of the
Preparer role, prove that each of its players behaves correctly and show that
Trip interacts with them appropriately.

  Since several classes act as Preparers, the test for this role should be written
once and shared by every player, via Ruby modules.

  The module above tests and documents the Preparer interface. It proves that
@object responds tp prepare_trip.

  This test proves that Mechanic is a Preparer. The same pattern follows for
Driver and TripCoordinator. The test_implements_the_preparer_interface tests an
incoming message and therefore belongs with the receiving object's test.

  Since incoming messages go hand in hand with outgoing messages, once proved
that all receivers implement prepare_trip correctly, now it is time to prove that
Trip correctly sends it. Proving that messages got sent is done by setting
expectations on a mock.

  This test proves that Trip collaborates with Prepares using the correct interface.
Since Trip is the Preparable in the application, the test above should live in
TripTest. If another Preparable comes along, this test should be extracted to a
module, so it can be shared.
=end
