# bad ❌
class Bicycle
	attr_reader :style, :size, :tape_color,
							:front_shock, :rear_shock

	def initialize(args)
		@style = args[:style]
		@size = args[:size]
		@tape_color = args[:tape_color]
		@front_shock = args[:front_shock]
		@rear_shock = args[:rear_shock]
	end

	def spares
		if style == :road
			{
				chain: '10-speed',
				tire_size: '23',
				tape_color: tape_color
			}
		else
			{
				chain: '10-speed',
				tire_size: '2.1',
				rear_shock: rear_shock
			}
		end
	end
end

bike = Bicycle.new(
	style: :mountain,
	size: 'S',
	front_shock: 'Manitou',
	rear_shock: 'Fox'
)

 #<Bicycle:0x00007faf3f1c28c0 @style=:mountain, @size="S", @tape_color=nil, @front_shock="Manitou", @rear_shock="Fox">

=begin
The code above illustrates an antipattern, where bikes from both bike styles are
set on initialize and spare now checks the style property in order to return
the correct set.

The class also has default strings directly inside itself.
It is not possible to predict if a part has been initialized and in order to
call tape_color or front_shock you will probably be tempted to call style first.

If you see the class of an object as an attribute that holds the category of
self, the condition that checks for style is no different from the case statement
that checked for class names in the duck typing example.

💡 The presence of this antipattern indicates a missing subclass

Road and Mountain bikes share a lot in common but some behavior is applied to
road bikes only and some other only to mountain bikes. This is exactly what
nheritance solves: highly related types that share common behavior but differ
along some dimensions.
=end
