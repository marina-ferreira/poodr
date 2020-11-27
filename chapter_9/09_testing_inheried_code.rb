require 'minitest/autorun'
require_relative '../chapter_6/05_decoupling_with_hook_messages.rb'

module BicycleInterfaceTest
  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end

  def test_responds_to_default_chain
    assert_respond_to(@object, :default_chain)
  end

  def test_responds_to_chain
    assert_respond_to(@object, :chain)
  end

  def test_responds_to_size
    assert_respond_to(@object, :size)
  end

  def test_responds_to_tire_size
    assert_respond_to(@object, :tire_size)
  end

  def test_responds_to_spares
    assert_respond_to(@object, :spares)
  end
end

class BicycleTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new({ tire_size: 0 })
  end
end

class RoadBikeTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = RoadBike.new
  end
end

=begin
  The goal for the chapter 6 hierarchy is to prove that all objects in that
hierarchy honor their contract. The Liskov Substitution Principle declares that
subtypes should be substitutable for their supertypes (violations generate
unreliable objects that don't behave as expected).

  The easiest way to prove that objects obey Liskov is to write a shared test
for the common contract and include this test in every object.

  The BicycleInterfaceTest defines what it means to be a Bicycle. Any object
that passes this test can be trusted to act like a Bicycle. By including the
interface test in all subclasses accidental regressions are prevented and the
interface is well documented.
=end
