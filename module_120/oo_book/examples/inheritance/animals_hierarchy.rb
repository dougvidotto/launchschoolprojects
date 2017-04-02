module Swimmable
	def swim
		puts "I am swimming!"
	end
end

class Animal
end

class Fish < Animal
	include Swimmable
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
	include Swimmable
end

sparky = Dog.new
pawns = Cat.new
neemo = Fish.new

sparky.swim
pawns.swim
neemo.swim
