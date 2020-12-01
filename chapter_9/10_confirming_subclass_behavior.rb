require 'minitest/autorun'
require_relative '../chapter_6/05_decoupling_with_hook_messages.rb'
require_relative '09_testing_inheried_code.rb'

module BicycleSubclassTest
  def test_responds_to_post_initialize
    assert_respond_to(@object, :post_initialize)
  end

  def test_responds_to_spares
    assert_respond_to(@object, :spares)
  end

  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end
end

class RoadBikeTest < Minitest::Test
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = RoadBike.new
  end
end

class MountainBikeTest < Minitest::Test
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = MountainBike.new
  end
end

=begin
  The abstract superclass Bicycle imposes requirements upon its subclasses. The
subclasses should share a common test to prove that each one meets the
requirements. The subclasses are not obliged to implement every method (in this
case only default_tire_size is required), but it proves they can respond correctly
to these messages. The test proves that the object correctly acts like a
subclass of Bicycle.
=end
