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
    @hours, @minutes = (@minutes + minutes).divmod(60).map.with_index do |time, idx|
      idx.odd? ? time : @hours + time
    end
    @hours = @hours.divmod(24).first > 0 ? @hours.divmod(24).first - 1 : @hours
    Clock.new(@hours, @minutes)
  end
  
  def -(minutes)
    @hours, @minutes = (@minutes - minutes).divmod(60).map.with_index do |time, idx|
      idx.odd? ? time : @hours + time
    end
    @hours = @hours < 0 ? @hours.divmod(24).last: @hours
    Clock.new(@hours, @minutes)
  end
  
  def ==(other_clock)
    return false unless other_clock.is_a?(Clock)
    to_s == other_clock.to_s
  end
end
