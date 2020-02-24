class Time_slots
	attr_accessor :time_slot, :next_open_time, :scheduled_meetings

	def initialize(time_slot)
		@time_slot = time_slot
		@next_open_time = Scheduler.schedulable_time[:starts_at]
		@scheduled_meetings = []
	end

	def meetings
		@scheduled_meetings.map{ |m| m[:Meeting]}
	end

	def can_hold_a_meeting?(duration)
		end_time = @next_open_time + duration
		end_time < Scheduler.scheduled_meetings[:ends_at]
	end

	def add(meeting)
		if Scheduler.falls_during_working_hours?(@next_open_time, @next_open_time + Meeting.duration)
			@next_open_time = Scheduler.restricted_timeframe[:ends_at]
			add(Meeting)
			return
		end
	end

	new_meeting = { meeting: Meeting, starts_at: @next_free_at, ends_at: @next_free_at + Meeting.duration }
    @scheduled_meetings << new_meeting
    @next_free_at = new_meeting[:ends_at]
    new_meeting
end