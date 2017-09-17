class CircularBuffer
  def initialize(buffer_size)
    @buffer_size = buffer_size
    @buffer = []
  end

  def read
    value = @buffer.shift
    raise BufferEmptyException if value.nil?
    value
  end

  def write(value)
    return if value.nil?
    raise BufferFullException if @buffer.size == @buffer_size
    @buffer << value
  end

  def write!(value)
    return if value.nil?
    if @buffer.size == @buffer_size
      @buffer.shift
    end
    write(value)
  end

  def clear
    @buffer = []
  end
end

class CircularBuffer::BufferEmptyException < StandardError
end

class CircularBuffer::BufferFullException < StandardError
end