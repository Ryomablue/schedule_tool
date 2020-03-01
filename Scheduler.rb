require 'time'

class Scheduler
	def self.schedulable_time
	    {starts_at: Time.parse("9:00"), ends_at: Time.parse("17:00")}
	end

	def time_in_day
	    start_time = Scheduler.schedulable_time[:starts_at]
	    end_time = Scheduler.schedulable_time[:ends_at]
	    work_hours = (end_time - start_time)/3600
	end

	def schedule(length, first_meeting, prev_end_time, type)
	   if first_meeting == 0
	    	start_of_meeting = Scheduler.schedulable_time[:starts_at]
	    elsif first_meeting != 0 && type == :offsite
	    	start_of_meeting = prev_end_time + 60*30
	    else 
	    	start_of_meeting = prev_end_time
	    end

	    end_of_meeting = start_of_meeting + length*60*60

	    return scheduled_time = {:start_time => start_of_meeting, :end_time => end_of_meeting}
	end
end