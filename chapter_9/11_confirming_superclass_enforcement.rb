class BicycleTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new({ tire_size: 0 })
  end

  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) { @bike.default_tire_size }
  end
end

=begin
  Bicycles force their subclasses to implement default_tire_size although the
requirement applies to subclasses, the actual enforcement behavior is in Bicycle,
the test should therefore live there.
=end
