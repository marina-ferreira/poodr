require 'date'

module Schedulable
	attr_writer :schedule

	def schedule
		@schedule ||= ::Schedule.new
	end

	def schedulable?(start_date, end_date)
		!scheduled?(start_date - lead_days, end_date)
	end

	def scheduled?(start_date, end_date)
		schedule.scheduled?(self, start_date, end_date)
	end

	def lead_days # includes may override
		0
	end
end

class Schedule
	def scheduled?(schedulable, start_date, end_date)
		puts "This #{schedulable.class} " +
				 "is not scheduled \n" +
				 "between #{start_date} and #{end_date}"

		false
	end
end

class Bicycle
	include Schedulable

	def lead_days
		1
	end
end

class Mechanic
	include Schedulable

	def lead_days
		4
	end
end

class Vehicle
	include Schedulable

	def lead_days
		3
	end
end

starting = Date.parse("2015/09/04")
ending = Date.parse("2015/09/10")

bike = Bicycle.new
bike.schedulable?(starting, ending)
# This Bicycle is not scheduled
# between 2015-09-03 and 2015-09-10
# => true

=begin
  Bicycle is not the only Schedulable object, so that logic has to be extracted
in order to be shareable with Mechanic and Vehicle as well.

  The lead_days method is a hook that follows the Template Method Pattern:

  💡 If an object sends a method it has to implement it.
=end
