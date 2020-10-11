=begin
Instead of looking at Mechanic, TripCoordinator and Driver as three separate
objects, it's possible to group all of them as a Preparer. Preparers want to
prepare trips, so every Preparer knows how to answer to prepare_trip.

💡 What is a Preparer?
It's an *abstraction*, it's a public interface based on a idea.

Abstractions are possible when objects are treated as if they are defined by
their behavior rather than its class.
=end

=begin
* Polymorphism

- the state of having many forms
- in OOP: the ability of many different objects to respond to the same message with their own implementation of it. A single message has then many (poly) forms (morphs)
- duck-typing, inheritance and behavior sharing modules are a kind of polymorphism
=end

=begin
* Recognizing Hidden Ducks

The following pattern indicates the presence of a hidden duck:

1. Case statement that switch on class

  It switches on class names of domain objects of your application. This pattern
  indicates that classes have something in common.

2. kind_of? or is_a?

  There are several ways to check the type of an object. Using either *kind_of?*
  or *is_a?* (synonymous) is pretty much the same as using *case/switch* and it
  causes you the same problems.

3. responds_to?

  It slightly decreases the number of dependencies but the code is still too
  much bound to class, although it does not depend on class names directly.
=end

# not ok ❌
if preparer.kind_of? Mechanic
	preparer.prepare_bicycles(bicycles)
elsif preparer.kind_of? TripCoordinator
	preparer.buy_food(customers)
elsif preparer.kind_of? Driver
	preparer.gas_up(vehicle)
	preparer.fill_water_tank(vehicle)
end

# not ok ❌
if preparer.respond_to?(:prepare_bicycles)
	preparer.prepare_bicycles(bicycles)
elsif preparer.respond_to?(:buy_food)
	preparer.buy_food(customers)
elsif preparer.respond_to?(:gas_up)
	preparer.gas_up(vehicle)
	preparer.fill_water_tank(vehicle)
end
