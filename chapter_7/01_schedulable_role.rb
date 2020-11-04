require 'date'

class Schedule
	def scheduled?(schedulable, start_date, end_date)
		puts "This #{schedulable.class} " +
				 "is not scheduled \n" +
				 "between #{start_date} and #{end_date}"

		false
	end
end

class Bicycle
	attr_reader :schedule, :size, :chain, :tire_size

	def initialize(args = {})
		@schedule = args[:schedule] || Schedule.new
		# [...]
	end

	def schedulable?(start_date, end_date)
		!scheduled?(start_date - lead_days, end_date)
	end

	def scheduled?(start_date, end_date)
		schedule.scheduled?(self, start_date, end_date)
	end

	def lead_days
		1
	end
end

starting = Date.parse('2015/09/04')
ending = Date.parse('2015/09/10')

bike = Bicycle.new
bike.schedulable?(starting, ending)
# => This Bicycle is not scheduled
#		 between 2015-09-04 and 2015-09-10

# => true


=begin
  Objects should manage themselves and contain their own behavior. In the diagram
the instigating object wants to know if a Target is available, but it doesn't
ask it directly, instead it asks a third party: Schedule.

  In object oriented languages if you want to check if a string is empty, a
message should be sent directly to the string. There shouldn't be an object in
between. That would be adding an unnecessary dependency. Asking Schedule if a
Bicycle is scheduled is the same as asking StringUtils if string is empty.

my_string.empty? 👍🏻

StringUtils.empty(my_string) 👎🏻

  If your interest is in object B, you shouldn't have to know about object A if A
is only used to get information out of B. Target should be the ones responding
to schedulable?. The diagram shows the schedulable? method added to the
Schedulable role.

  The instigating object now asks Bicycle directly for its schedulability. The
knowledge of the Schedule class has been hidden inside Bicycle. Object that
interact with Bicycle no longer have to know about Schedule, the dependency on
Schedule has been removed.
=end
