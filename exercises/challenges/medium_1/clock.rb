class Clock
  
  def initialize(hours, minutes)
    @hours = hours
    @minutes = minutes
  end
  
  def self.at(hours, minutes=0)
    Clock.new(hours, minutes)
  end
  
  def to_s
    sprintf("%.2d:%.2d", @hours, @minutes)
  end
  
  def +(minutes)
    total_minutes = @hours * 60 + @minutes + minutes
    calculate_time(total_minutes)
    Clock.new(@hours, @minutes)
  end
  
  def -(minutes)
    total_minutes = @hours * 60 + @minutes - minutes
    calculate_time(total_minutes)
    Clock.new(@hours, @minutes)
  end
  
  def ==(other_clock)
    return false unless other_clock.is_a?(Clock)
    to_s == other_clock.to_s
  end

  def calculate_time(total_minutes)
    @hours = (total_minutes / 60) % 24
    @minutes = total_minutes % 60 
  end
end
