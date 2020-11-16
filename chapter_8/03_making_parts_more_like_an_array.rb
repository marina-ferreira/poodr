=begin
  The problem: road_bike.spares.size and road_bike.parts.size should behave the
same way. While the first statement works fine, the second one returns an error:
NoMethodError (undefined method `size' for #<Parts:0x00007ff42493d440>)
=end

# 1. Add size method to Parts
# While the following pattern works, it would be repeated for every Array
# method needed.

def size
	parts.size
end

# 2. Inherit from Array
# Many methods of Array return new arrays. Unfortunately these methods return
# new instances of the Array class, not new instances of your subclass.

class Parts < Array
	def spares
		select { |part| part.needs_spare }
	end
end

combo_parts = (mountain_bike.parts + road_bike.parts)
combo_parts.size
#=> 7

combo_parts.spares
#=> NoMethodError: undefined method 'spares' for #<Array:...>

# 3. Forwardable/Enumerable

require 'forwardable'

class Parts
	extend Forwardable
	def_delegators :@parts, :size, :size
	include Enumerable

	def initialize(parts)
		@parts = parts
	end

	def spares
		select { |part| part.needs_spare }
	end
end

=begin
each and size are delegated to the @parts array and includes Enumerable to get
common traversal and searching methods. Sending + to an instance of Parts results
in NoMethodError. Parts can now respond to size and correctly raises errors if
you try to treat it as an Array, so this last version is good enough.
=end

mountain_bike.spares.size
#=> 3

mountain_bike.parts.size
#=> 4
