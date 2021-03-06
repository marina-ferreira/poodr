# bad ❌
class Bicycle
	attr_reader :style, :size, :tape_color

	def initialize(args)
		@style = args[:style]
		@size = args[:size]
		@tape_color = args[:tape_color]
	end

	def spares
    {
      chain: '10-speed',
      tire_size: '23',
      tape_color: tape_color
    }
	end
end

class MountainBike < Bicycle
	attr_reader :front_shock, :rear_shock

	def initialize(args)
		@front_shock = args[:front_shock]
		@rear_shock = args[:rear_shock]
		super(args)
	end

	def spares
		super.merge({ rear_shock: rear_shock, front_shock: front_shock })
	end
end

mountain_bike = MountainBike.new(
	size: 'S',
	front_shock: 'Manitou',
	rear_shock: 'Fox'
)

mountain_bike.size
#=> 'S'

mountain_bike.spares
#=> {
#  :tire_size => '23', (wrong)
#  :chain => '10-speed',
#  :tape_color => nil, (not applicable)
#  :front_shock => 'Manitou',
#  :rear_shock => 'Fox'
# }

=begin
  An attempt to solve the missing inheritance issue is to remove the MountainBike behavior to a subclass. That won't work because Bicycle is mixing behavior that is general to all bikes with behavior specific to RoadBikes. As a result, on instatiating a MountainBike, some of its behavior is correct, some is wrong and some doesn't even apply.

	💡 Class inheritance should follow generalization-specialization relationship.
=end
