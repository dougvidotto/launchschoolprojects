class Student

	def initialize(name, grade)
		@name = name
		@grade = grade
	end

	def name
		@name
	end

	def better_grade_than?(another_student)
		grade > another_student.grade
	end

	protected
	def grade
		@grade
	end
end

joe = Student.new("Joe", 8)
bob = Student.new("Bob", 6)

puts "Well done!" if joe.better_grade_than?(bob)
joe.grade