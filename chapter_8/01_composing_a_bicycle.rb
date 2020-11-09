class Bicycle
	attr_reader :size, :parts

	def initialize(args = {})
		@size = args[:size]
		@parts = args[:parts]
	end

	def spares
		parts.spares
	end
end

class Parts
	attr_reader :chain, :tire_size

	def initialize(args = {})
		@chain = args[:chain] || default_chain
		@tire_size = args[:tire_size] || default_tire_size
		post_initialize(args)
	end

	def spares
		{
			tire_size: tire_size,
			chain: chain
		}.merge(local_spares)
	end

	def default_tire_size
		raise NotImplemented
	end

	# subclasses may override
	def post_initialize(args)
		nil
	end

	def local_spares
		{}
	end

	def default_chain
		'10-speed'
	end
end

class RoadBikeParts < Parts
	attr_reader :tape_color

	def post_initialize(args)
		@tape_color = args(:tape_color)
	end

	def local_spares
		{ tape_color: tape_color }
	end

	def default_tire_size
		'23'
	end
end

class MountainBikeParts < Parts
	attr_reader :front_shock, :rear_shock

	def post_initialize(args)
		@front_shock = args[:front_shock]
		@rear_shock = args[:rear_shock]
	end

	def local_spares
		{ rear_shock: rear_shock }
	end

	def default_tire_size
		'2.1'
	end
end

mountain_bike = Bicycle.new(
	size: 'L',
	parts: MountainBikeParts.new(rear_shock: 'Fox')
)

mountain_bike.size
#=> 'L'
mountain_bike.parts
#=> {
#	tire_size: '2.1',
#	chain: '10-speed',
#	rear_shock: 'Fox'
#}

=begin
  The Bicycle class is responsible for responding to a spares message, that
returns a list of spares parts. Bicycles have Parts (bicycle-parts relationship
is composition). The spares method can be delegated to Parts class.

  And to get the code working again, after the refactoring in Bicycle, the
extracted code should be placed into a hierarchy of Parts. The new code is not
much different from the hierarchy in chapter 6.

  Parts is an abstract class. Bicycle is composed of Parts and the latter has
two subclasses MountainBikeParts and RoadBikeParts.
=end
