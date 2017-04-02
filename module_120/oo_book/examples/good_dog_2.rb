class GoodDog

	attr_accessor :name, :height, :weight
	# initialize method works as the constructor of the class. Every object that is instantiated with new
	# it calls 'initialize' first
	def initialize(n, h, w)
		@name = n
		@height = h
		@weight = w
	end

	def speak
		"#{name} says Arf!!"
	end

	def info
		"#{name} weighs #{weight} and is #{height} tall."
	end
end

sparky = GoodDog.new("Sparky", "12 inches", "10 libs")
fido = GoodDog.new("Fido", "15 inches", "30 libs")

puts sparky.speak
puts fido.speak

puts sparky.info