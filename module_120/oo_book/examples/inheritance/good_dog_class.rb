class Animal
	attr_accessor :name

	def initialize(name)
		@name = "Default Name"
	end

	def speak
		"Hello!"
	end
end

class GoodDog < Animal
	def initialize(color, name)
		super(name)
		@color = color
	end

	def speak
  	super + " from your nice friend #{name}"
  end
end

class Cat < Animal
end

my_dog = GoodDog.new('brown', 'Sparky')
puts my_dog.speak

nice_cat = Cat.new('Pawn')
nice_cat.speak