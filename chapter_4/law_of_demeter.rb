# The Law of Demeter (LoD)

=begin
Demeter restricts the amount of objects to which a method may send messages:

* It does not allow routing a message to a third object via a second object of a different type
* You can only talk to your immediate neighbors
* Use only one dot
=end

# not ok ❌
class Trip
	# [...]

	def depart
		customer.bicycle.wheel.tire
		customer.bicycle.wheel.rotate
		hash.keys.sort.join(', ')
	end
end

=begin
* The message chains contained in depart method are called train wrecks
* Train wrecks indicate violation of LoD
* Train wrecks are an indication that object's public interfaces are missing.

The first two lines in the *depart* method are a chain that reaches across many objects to get either a distant attribute or behavior.

For attributes (stable ones) the LoD violation may have low risk (if your intention is to only retrieve the value). If you intend to change the value retrieved, you are actually implementing behavior that belongs in *Wheel*, which has a high cost and should be removed.

The last line although chained , is not a violation of LoD. Instead of counting the amount of objects, consider each car's type. All the intermediate objects are of the same type so it does not break LoD.

hash.keys = Enumerable
hash.keys.sort = Enumerable
hash.keys.sort.join() = String (Enumerable of String)
=end

# ok 🍀
class Trip
	# [...]

	def depart
		customer.ride
	end
end

=begin
* the ride method hides implementation details from Trip
* it reduces both context and its dependencies
=end
