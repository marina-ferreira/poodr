class Bicycle
	attr_reader :size, :chain, :tire_size

	def initialize(args = {})
		@size = args[:size]
		@chain = args[:chain] || default_chain
		@tire_size = args[:tire_size] || default_tire_size
	end

	def default_chain # common default
		'10-speed'
	end

	def default_tire_size
		raise NotImplementedError, "This #{self.class} cannot respond to:"
	end
end

class RoadBike
	attr_reader :tape_color

	def initialize(args)
		@tape_color = args[:tape_color]
		super(args)
	end

	def default_tire_size # subclass default
		'23'
	end
end

class MountainBike
	def initialize(args = {})
		@front_shock = args[:front_shock]
		@rear_shock = args[:rear_shock]
		super(args)
	end

	def default_tire_size # subclass default
		'2.1'
	end
end

class RecumbentBike < Bicycle
	def default_tire_size
		'9-speed'
	end
end

bent = RecumbentBike.new
# => NotImplementedError: This RecumbentBike cannot respond to: 'default_tire_size'

=begin
  Wrapping the default in methods is not only for good practice in general,
but here, that structure also allows for subclasses to override this methods,
specializing them.
=end
