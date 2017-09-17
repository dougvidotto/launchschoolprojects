# Input: 
# Buffer size
# A string that will be appended right after the last element that was added.
# if the buffer is empty, the string can be added to any place.
#
# Output
# read: eliminate the oldest value of the buffer and return this value
# write: put the item right after the last item that was added
# Algorithm
# I can use a hash to create the buffer.
# Each key is a position.
# Also, I can use two variables to keep he place where 
# it's the oldest and newest value

class CircularBuffer
  def initialize(buffer_size)
    @oldest_position = 0
    @newest = -1
    @buffer = Array.new(buffer_size) {|_| ''}
  end

  def read
    raise BufferEmptyException if is_empty?
    value = @buffer.fetch(@oldest_position)
    @buffer[@oldest_position] = ''
    @oldest_position += 1
    @oldest_position = 0 if @oldest_position == @buffer.size
    value
  end

  def write(value)
    return if value.nil?
    raise BufferFullException if is_full?
    @newest = @newest + 1 == @buffer.size ? 0 : @newest + 1
    @buffer[@newest] << value
  end

  def write!(value)
    return if value.nil?
    if is_full?
      @buffer[@oldest_position] = value
      @oldest_position = @oldest_position + 1 == @buffer.size ? 0 : @oldest_position + 1
    else
      write(value)
    end
  end

  def clear
    @buffer.each_with_index {|_, idx| @buffer[idx] = ''}
  end

  private
  
  def is_full?
    @buffer.count('') == 0
  end

  def is_empty?
    @buffer.count('') == @buffer.size
  end
end

class CircularBuffer::BufferEmptyException < StandardError
end

class CircularBuffer::BufferFullException < StandardError
end
