# Create new feature that arranges meetingCollection in 8 hour day
# If meetingCollection cannot fit, let user know "No, can't fit"
# 2 kinds of meetingCollection: onsite/offsite
# onsite: can be back to back w/o gaps
# offsite: 	-30 min buffer on either end (travel time)
# 			    -can overlap off-site meetingCollection
# 			    -can extends past Start/End of Day


require 'time'
require_relative 'Meeting'
require_relative 'Scheduler'
require_relative 'Time_slots'

t = Scheduler.new
$hoursInDay = t.time_difference

$meetings = {
  :m1 => Meeting.new("Meeting 1", 1.5, :onsite),
  :m2 => Meeting.new('Meeting 2', 2, :offsite),
  :m3 => Meeting.new('Meeting 3', 1, :onsite),
  :m4 => Meeting.new('Meeting 4', 1, :offsite),
  :m5 => Meeting.new('Meeting 5', 1, :offsite)
}

$timeslots = {
  :t1 => Time_slots.new("9:00", "10:30"),
  :t2 => Time_slots.new("10:30", "11:30"),
  :t3 => Time_slots.new("12:00", "1:00"),
  :t4 => Time_slots.new("1:30", "2:30"),
  :t5 => Time_slots.new("3:00", "5:00")
}

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

def set_timeslots

end

def sort_meetings
  $meetings.each do |key, value|
    puts "timeslots - #{value.name}"
  end
end


# Let user know that meetingCollection fit in day
  case can_fit_all_meetings?
  when 0..8
    set_timeslots
    sort_meetings
  else
    puts 'No, can’t fit'
  end