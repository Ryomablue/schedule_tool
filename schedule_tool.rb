# Create new feature that arranges meetingCollection in 8 hour day
# If meetingCollection cannot fit, let user know "No, can't fit"
# 2 kinds of meetingCollection: onsite/offsite
# onsite: can be back to back w/o gaps
# offsite: 	-30 min buffer on either end (travel time)
# 			    -can overlap off-site meetingCollection
# 			    -can extends past Start/End of Day


require 'time'
require_relative'Meeting'
require_relative 'Scheduler'

t = Scheduler.new
$hoursInDay = t.time_difference

$meetings = {
  :m1 => Meeting.new("Meeting 1", 1.5, :onsite),
  :m2 => Meeting.new('Meeting 2', 2, :offsite),
  :m3 => Meeting.new('Meeting 3', 1, :onsite),
  :m4 => Meeting.new('Meeting 4', 1, :offsite),
  :m5 => Meeting.new('Meeting 5', 1, :offsite)
}

#iterate through the meetingCollection of meetingCollection
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

# Let user know that meetingCollection fit in day
  case $hoursInDay
  when 0..8
    puts 'Yes, can fit'
    $meetings.each do |key, value|
    	puts "timeslot - #{value.name}"
    end
  else
    puts 'No, can’t fit'
  end