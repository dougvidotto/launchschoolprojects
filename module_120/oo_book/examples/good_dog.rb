class GoodDog
	# initialize method works as the constructor of the class. Every object that is instantiated with new
	# it calls 'initialize' first
	def initialize(name) 
		@name = name
	end

	def speak
		"#{@name} says Arf!!"
	end

	def name=(name)
		@name = name
	end

	def name
		@name
	end
end

sparky = GoodDog.new("Sparky")
fido = GoodDog.new("Fido")

puts sparky.speak
puts fido.speak

puts sparky.name
sparky.name = "Spartacus"
puts sparky.name