require 'minitest/autorun'
require_relative '../chapter_6/05_decoupling_with_hook_messages.rb'
require_relative '09_testing_inheried_code.rb'
require_relative '10_confirming_subclass_behavior.rb'

class StubbedBike < Bicycle
  include BicycleSubclassTest

  def default_tire_size
    0
  end

  def local_spares
    { saddle: 'painful' }
  end
end

class BicycleTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new({ tire_size: 0 })
    @stubbed_bike = StubbedBike.new
  end

  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) { @bike.default_tire_size }
  end

  def test_includes_local_spares_in_spares
    assert_equal(
      @stubbed_bike.spares,
      { tire_size: 0, chain: '10-speed', saddle: 'painful' }
    )
  end
end

=begin
  Creating an instance of an abstract superclass may be hard and the instance
may not have the behavior you expect. To overcome this you can use the Liskov
Substitution Principle and manufacture a testable instance of the bike by
subclassing it.
  The StubbedBike proves that Bicycle correctly includes the subclasses
local_spares contribution in spares. In order to prevent StubbedBike from
becoming obsolete, since it is just another subclass of Bicycle, it should
pass the BicycleSubclassTest.

*** Test for Hierarchies Rules ***

  1. Shareable test for overall interface
  2. Shareable test for subclass responsibilities
  3. Separate tests for each specialization
=end
