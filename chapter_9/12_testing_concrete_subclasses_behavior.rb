class RoadBikeTest < Minitest::Test
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = RoadBike.new
  end

	def test_puts_tape_color_in_local_spares
		assert_equal('red', @bike.local_spares[:tape_color])
	end
end

=begin
  For the RoadBike class the only thing left to test is the specializations.
Those should be tested without embedding superclass knowledge. RoadBike should
ensure that local_spares work while maintaining its ignorance about the spares
method (BicycleInterfaceTest already tests that RoadBike responds correctly to
spares). Responding to local_spares though, is clearly RoadBike's responsibility.
=end
