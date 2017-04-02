class GoodDog
	DOG_YEARS = 7

	attr_accessor :name, :age #Using attr accessors, it already gives us @name and @age

	def initialize(name, age)
		self.name = name
		self.age = DOG_YEARS * age
	end

	def to_s
		"My name is #{name} and I am #{age / DOG_YEARS} years old"
	end
end

sofia = GoodDog.new("Sofia", 13)
puts sofia.age
puts sofia