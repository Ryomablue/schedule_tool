  require 'time'
  require_relative 'Meeting'
  require_relative 'Scheduler'

class Planner

  def schedule_meetings(set_of_meetings)
    case can_fit_all_meetings?(set_of_meetings)
    when 0..8
      puts sort_meetings(set_of_meetings)
    else
      puts 'No, can’t fit'
    end
  end

  def can_fit_all_meetings?(meetings)
  t = Scheduler.new
  hoursInDay = t.time_in_day

    meetings.each do |key,value|
      case value.type
      when :offsite
        duration = value.duration + 0.5
      else
        duration = value.duration
      end
      remainingHoursInDay = hoursInDay - duration
      hoursInDay = remainingHoursInDay
    end

    return hoursInDay
  end

  def set_timeslots(sorted_meetings)
    t1 = Scheduler.new
    arr = []
    prev_end_time = Time.parse("00:00")
    first_meeting = 0 

    sorted_meetings.each do |key,value|
      result = t1.schedule(value[:duration], first_meeting, prev_end_time, value[:type])
      arr << "#{result[:start_time].strftime('%H:%M')} - #{result[:end_time].strftime('%H:%M')} - #{key}"
      first_meeting = first_meeting + 1
      prev_end_time = result[:end_time]
    end
    return arr
  end

  def sort_meetings(set_of_meetings)
    onsite = Hash.new
    offsite = Hash.new

    set_of_meetings.each do |key,value|
      meeting = value.name
      duration = value.duration
      type = value.type
      meet_details = {:duration => duration, :type => type}

      if type == :onsite
        onsite.store(meeting, meet_details)
      else
        offsite.store(meeting, meet_details)
      end
    end
    sorted_meetings = onsite.merge(offsite)
    scheduled_meetings = set_timeslots(sorted_meetings)
  end
end

set_of_meetings1 = {
  :m1 => Meeting.new("Meeting 1", 1.5, :onsite),
  :m2 => Meeting.new('Meeting 2', 2, :offsite),
  :m3 => Meeting.new('Meeting 3', 1, :onsite),
  :m4 => Meeting.new('Meeting 4', 1, :offsite),
  :m5 => Meeting.new('Meeting 5', 1, :offsite)
}

test1 = Planner.new
test1.schedule_meetings(set_of_meetings1)

set_of_meetings2 = {
  :m1 => Meeting.new("Meeting 1", 4, :offsite),
  :m2 => Meeting.new('Meeting 2', 4, :offsite),
}

test2 = Planner.new
test2.schedule_meetings(set_of_meetings2)

set_of_meetings3 = {
  :m1 => Meeting.new("Meeting 1", 3, :onsite),
  :m2 => Meeting.new('Meeting 2', 2, :offsite),
  :m3 => Meeting.new('Meeting 3', 1, :onsite),
  :m4 => Meeting.new('Meeting 4', 0.5, :onsite)
}

test3 = Planner.new
test3.schedule_meetings(set_of_meetings3)


