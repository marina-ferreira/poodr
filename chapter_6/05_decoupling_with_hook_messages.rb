# ok 🍀
class Bicycle
	attr_reader :size, :chain, :tire_size

	def initialize(args = {})
		@size = args[:size]
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
		raise NotImplementedError, "This #{self.class} cannot respond to:"
	end

 # subclasses may/may not override
  def post_initialize(args)
     nil
   end

	def default_chain
		'10-speed'
	end

	def local_spares
		{}
	end
end

# ok 🍀
class RoadBike < Bicycle
	attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

	def default_tire_size
		'23'
	end

	def local_spares
		{ tape_color: tape_color }
	end
end

# ok 🍀
class MountainBike < Bicycle
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

# ok 🍀
class RecumbentBike < Bicycle
	attr_reader :flag

	def post_initialize(args)
		@flag = args[:flag]
	end

	def local_spares
		{ flag: flag }
	end

	def default_tire_size
		'28'
	end

	def default_chain
		'9-speed'
	end
end

=begin
  The super call in subclasses can be substituted by hook messages sent by
the superclass.

  💡 Hook messages exist solely to provide subclass a way to contribute with
    specific information by implementing matching methods.

  The hook message removed the super call, as well as the initialize method.
The initialization now is completely under the abstract superclass power.
Subclass doesn't even know anymore when that initialization occurs, it just
contributes to it, when requested by the superclass.

  RoadBike no longer knows about Bicycle having a spares method, neither that
it returns a hash. Now it only knows about its own specific spares. Coupling
has been reduced.

  Using this patterns make it easy to create a new bike category. All the
subclasses have to do is to implement the Template Methods.
=end
