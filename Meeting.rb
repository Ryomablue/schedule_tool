class Meeting
  attr_accessor :name, :duration, :type
  def initialize(name, duration, type)
    @name = name
    @duration = duration
    @type = type
  end
end