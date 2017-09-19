# Input
# A day of the week like monday, tuesday, etc and a schedule like first sunday, or last friday, etc.
# Output:
# The exactly date of the week day and the schedule
# Algorithm
# Initialize with first day of the month
# Calculate the difference between the current week day until the day we want
#
#
# if WEEK_DAYS[week_day] < current
#   current_day += 7 - (current - WEEK_days[week_day])
# else
#   current_day += WEEK_DAYS[week_day] - current
# end

# Reaching the correct week day, now I only have to add 7 days until I find the correct day
# FIRST: already found
# second: +7
# third + 7 + 7
# fourth: +7 + 7 + 7 + 7
# last: I can do the opposite. Put the date at the last day of the month and going down until
# I find the day of the week I want

# teenth: Put the day at 13th. Do the same math as the others

require 'date'

class Meetup

  WEEK_DAYS = {
               sunday: 0,
               monday: 1,
               tuesday: 2,
               wednesday: 3,
               thursday: 4,
               friday: 5,
               saturday: 6
              }

  def initialize(month, year)
    @date = Date.new(year, month, 1)
  end

  def day(week_day, schedule)
    case schedule
    when :first, :second, :third, :fourth
      at_beginning(week_day, schedule)
    when :last
      at_end(week_day)
    else
      the_teenth(week_day)      
    end
  end

  private

  def at_beginning(week_day, schedule)
    if @date.wday > WEEK_DAYS[week_day]
      @date = @date.next_day(7 - (@date.wday - WEEK_DAYS[week_day]))
    else
      @date = @date.next_day(WEEK_DAYS[week_day] - @date.wday)
    end
    case schedule
    when :second
      @date = @date.next_day(7)
    when :third
      @date = @date.next_day(14)
    when :fourth
      @date = @date.next_day(21)
    end
    @date
  end

  def at_end(week_day)
    @date = @date.next_month.next_day(-1)
    if @date.wday > WEEK_DAYS[week_day]
      @date = @date.next_day(WEEK_DAYS[week_day] - @date.wday)
    elsif @date.wday < WEEK_DAYS[week_day]
      @date = @date.next_day((WEEK_DAYS[week_day] - @date.wday) - 7)
    end
    @date
  end

  def the_teenth(week_day)
    @date = @date.next_day(12) # Put the date at the first 'teeth', that is 13th day of the month
    if @date.wday > WEEK_DAYS[week_day]
      @date = @date.next_day(7 - (@date.wday - WEEK_DAYS[week_day]))
    elsif @date.wday < WEEK_DAYS[week_day]
      @date = @date.next_day(WEEK_DAYS[week_day] - @date.wday)
    end
    @date
  end
end
