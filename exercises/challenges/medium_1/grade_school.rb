class School
  def initialize
    @roster = Hash.new { |hsh, key| hsh[key] = [] }
  end

  def add(std_name, grade)
    @roster[grade] << std_name
    @roster[grade].sort!
  end

  def to_h
    @roster.sort.to_h
  end

  def grade(grade_num)
    @roster[grade_num]
  end
end