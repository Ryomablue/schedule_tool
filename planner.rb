  require 'time'
  require_relative 'Meeting'
  require_relative 'Scheduler'

  $meetings = {
    :m1 => Meeting.new("Meeting 1", 1.5, :onsite),
    :m2 => Meeting.new('Meeting 2', 2, :offsite),
    :m3 => Meeting.new('Meeting 3', 1, :onsite),
    :m4 => Meeting.new('Meeting 4', 1, :offsite),
    :m5 => Meeting.new('Meeting 5', 1, :offsite)
  }

class Planner
  t = Scheduler.new
  $hoursInDay = t.time_in_day

  def schedule_my_meetings
    case can_fit_all_meetings?
    when 0..8
      puts sort_meetings
    else
      puts 'No, can’t fit'
    end
  end

  def can_fit_all_meetings?
    $meetings.each do |key,value|
      case value.type
      when :offsite
        duration = value.duration + 0.5
      else
        duration = value.duration
      end
      remainingHoursInDay = $hoursInDay - duration
      $hoursInDay = remainingHoursInDay
    end

    return $hoursInDay
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

  def sort_meetings
    onsite = Hash.new
    offsite = Hash.new

    $meetings.each do |key,value|
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

test1 = Planner.new
test1.schedule_my_meetings
