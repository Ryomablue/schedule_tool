class Scheduler
    def self.schedulable_time
      {starts_at: Time.parse("9:00"), ends_at: Time.parse("17:00")}
    end

    def time_difference
    	start_time = Scheduler.schedulable_time[:starts_at]
    	end_time = Scheduler.schedulable_time[:ends_at]
    	difference = (end_time - start_time)/3600
    end
end