# Protected

# ok 🍀
# send self.fun_factor from within instances of Trip
# self is the explicit receiver

class Trip
	def some_public_method
		self.fun_factor * some_variable

		a_trip = Trip.new
		a_trip.fun_factor * some_variable # only from within a class where self
	end                                 # is the same kind of a_trip

	protected

	def fun_factor
		# [...]
	end
end

# not ok ❌
# send a_trip.fun_factor from a class which
# self is not the same kind as a_trip

class AnotherClass
	def whatever_method
		a_trip = Trip.new([...])
		factor = a_trip.fun_factor ❌
	end
end
