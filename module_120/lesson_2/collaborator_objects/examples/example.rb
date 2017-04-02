class Pet

end

class Dog < Pet

end

class Cat < Pet

end

class Person
	attr_accessor :name, :pet

	def initialize(name, pet)
		@name = name
		@pet = pet
	end
end

dog = Dog.new
cat = Cat.new

doug = Person.new("Doug", dog)
paty = Person.new("Paty", doug)
puts paty.pet.name
