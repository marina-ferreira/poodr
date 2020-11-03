# not ok ❌
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

	def spares
		{ tire_size: tire_size, chain: chain }
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

	def spares
		super.merge({ tape_color: tape_color })
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

	def spares
		super.merge({ rear_shock: rear_shock })
	end
end

=begin
  Right now, the spares method returns a hash with the common parts and
subclasses implement the same spares method and call super for merging its
specific parts.

  For that to work, every subclass needs to know that their superclass responds
to the spares method and that it returns a hash that can be merged. The subclass
not only knows the superclass, it also knows how to interact with it. Knowledge
about other classes creates dependencies and dependencies couple objects together.
The initialize method follows the same pattern and therefore causes the same
problems.

💡 The presence of the super keyword on a method indicates tightly coupled objects

When a new bike class comes around (as the example below), one might miss the
super call either in the initialize  method or spares. That would cause attributes
to not be set and common parts to be missing on spares call.
=end

# not ok ❌
class RecumbentBike < Bicycle
	def initialize(args = {}) # missing super call
		@flag = args[:flag]
	end

	def default_tire_size
		'9-speed'
	end

	def spares
		super.merge({ flag: flag })
	end
end

bent = RecumbentBike.new(flag: 'tall and orange')
bent.spares
# => {
	tire_size: nil,
	chain: nil,
	flag: 'tall and orange'
}
