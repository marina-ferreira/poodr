# Private

# ok 🍀
# send fun_factor from within instances of Trip
# self is the implicit receiver

class Trip
	def some_public_method
		fun_factor * some_variable
	end

	private

	def fun_factor
		# [...]
	end
end

# not ok ❌
# send self.fun_factor from within instances of Trip
# send a_trip.fun_factor from another object

class Trip
	def some_public_method
		self.fun_factor * some_variable ❌
	end

	private

	def fun_factor
		# [...]
	end
end

class AnotherClass
	def whatever_method
		a_trip = Trip.new([...])
		factor = a_trip.fun_factor ❌
	end
end
