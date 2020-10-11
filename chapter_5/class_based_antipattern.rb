# not ok ❌
class Trip
	attr_reader :bicycles, :customer, :vehicle

	def prepare(mechanic)
		mechanic.prepare_bicycles(bicyles)
	end
end

class Mechanic
	def prepare_bicycles
		bicycles.each do |bicycle|
			prepare_bicycle(bicycle)
		end
	end

	def prepare_bicycle
		# [...]
	end
end

=begin
This code may look harmless at first sight. Although Trip does not have an
explicit dependency on Mechanic, it does expect to be holding an object that
responds to prepare_bicycles.
Once the requirements are extended that dependency will grow.
=end

# not ok ❌
class Trip
	attr_reader :bicycles, :customer, :vehicle

	def prepare(preparers)
		preparers.each do |preparer|
			case preparer
			when Mechanic
				preparer.prepare_bicycles(bicycles)
			when TripCoordinator
				preparer.buy_food(customers)
			when Driver
				preparer.gas_up(vehicle)
				preparer.fill_water_tank(vehicle)
			end
		end
	end
end

class TripCoordinator
	def buy_food(customers)
		# [...]
	end
end

class Driver
	def gas_up(vehicle)
		# [...]
	end

	def fill_water_tank(vehicle)
		# [...]
	end
end

=begin
Preparer now can be of any of the three types and each type responds to different
messages. The case statement generated direct dependencies on three different
classes, their methods and its arguments. Distant changes will have side effects
on the code.
=end
