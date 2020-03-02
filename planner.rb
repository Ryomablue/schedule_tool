require 'time'

class Meeting
  attr_accessor :name, :duration, :type
  def initialize(name, duration, type)
    @name = name
    @duration = duration
    @type = type
  end
end

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
      elsif type == :offsite
        start_of_meeting = prev_end_time + 60*30
      else 
        start_of_meeting = prev_end_time
      end

      end_of_meeting = start_of_meeting + length*60*60

      return scheduled_time = {:start_time => start_of_meeting, :end_time => end_of_meeting}
  end
end

class Planner
  def schedule_meetings(set_of_meetings)
    case can_fit_all_meetings?(set_of_meetings)
    when 0..8
      puts "Here is a recommended schedule for your meetings: "
      puts sort_meetings(set_of_meetings)
    else
      puts 'Sorry, the meeting(s) can’t fit into one work day'
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
      arr << "#{result[:start_time].strftime('%I:%M %p')} - #{result[:end_time].strftime('%I:%M %p')} - #{key}"
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

      case value.type
      when :onsite
        onsite.store(meeting, meet_details)
      else
        offsite.store(meeting, meet_details)
      end
    end
    sorted_meetings = onsite.merge(offsite)
    scheduled_meetings = set_timeslots(sorted_meetings)
  end
end

def user_input
  set_of_meetings = {}
  input = ""
  name = ""
  duration = ""
  type = ""

  puts "Do you have a meeting to add? Yes/No "
  input = gets.chomp.downcase

  while input == "yes" do 
    print "What is the meetings name?: "
    name = gets.chomp

    print "How long is will the meeting be?: "
    duration = gets.to_f

    print "Is the location onsite or offsite?: " 
    type = gets.to_sym

    set_of_meetings[name] = Meeting.new(name, duration, type)

    print "Would you like to add another meeting? Yes/No: "
    input = gets.chomp.downcase
  end
  if !set_of_meetings.empty?
    user_input = Planner.new
    user_input.schedule_meetings(set_of_meetings)
  end
end

user_input


