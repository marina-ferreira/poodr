# chain = Part.new(name: 'chain', description: '10-speed')
# road_tire = Part.new(name: 'tire_size', description: '23')
# tape = Part.new(name: 'tape_color', description: 'red')

# road_bike_parts = Parts.new([chain, road_tire, tape])
# road_bike = Bicycle.new(size: 'L', parts: road_bike_parts)

=begin
  By injecting Part objects in the initialization of Bicycle (chain,
mountain_tire, front_shock) it is expected that Bicycle class has knowledge on
how to create those parts and which combinations should be used with each bike
type.

  It would be easier if you could just described the different bikes and use that
description to manufacture the correct Parts object for any bike.

  The 2-dimensional array defines three columns: name, description and needs_spare.
=end

road_config = [
	['chain', '10-speed'],
	['tire_size', '23'],
	['tape_color', 'red']
]

mountain_config = [
	['chain', '10-speed'],
	['tire_size', '2.1'],
	['front_shock', 'Manitou', false],
	['rear_shock', 'Fox']
]

### Creating the Parts Factory

# An object that manufactures other objects is a Factory.

module PartsFactory
	def self.build(config, part_class = Part, parts_class = Parts)
		parts_class.new(
			config.collect do |part_config|
				part_class.new(
					name: part_config[0],
					description: part_config[1],
					needs_spare: part_config.fetch(2, true)
				)
			end
		)
	end
end

road_parts = PartsFactory.build(road_config)
#<Parts:0x00007fbf978d27b0
# @parts=
#  [#<Part:0x00007fbf978d28a0
#    @description="10-speed",
#    @name="chain",
#    @needs_spare=true>,
#  #<Part:0x00007fbf978d2850
#    @description="23",
#    @name="tire_size",
#    @needs_spare=true>,
#  #<Part:0x00007fbf978d27d8
#    @description="red",
#    @name="tape_color",
#    @needs_spare=true>]>

# The Part class is so simple it can actually be replaced by an OpenStruct

class Part
	attr_reader :name, :description, :needs_spare

	def initialize(args = {})
		@name = args[:name]
		@description = args[:description]
		@needs_spare = args.fetch(:needs_spare, true)
	end
end

require 'ostruct'

module PartsFactory
	def self.build(config, parts_class = Parts)
		parts_class.new(
			config.collect { |part_config| create_part(part_config) }
		)
	end

	def self.create_part(part_config)
		OpenStruct.new(
			name: part_config[0],
			description: part_config[1],
			needs_spare: part_config.fetch(2, true)
		)
	end
end

mountain_parts = PartsFactory.build(mountain_config)
#<Parts:0x00007f9752006bd0
#  @parts=
#    [#<OpenStruct name="chain", description="10-speed", needs_spare=true>,
#    #<OpenStruct name="tire_size", description="2.1", needs_spare=true>,
#    #<OpenStruct name="front_shock", description="Manitou", needs_spare=false>,
#    #<OpenStruct name="rear_shock", description="Fox", needs_spare=true>]>
