class GoodDog
	@@number_of_dogs = 0 #Two @@ means that this is a class variable, not an instance variable

	def initialize
		@@number_of_dogs += 1
	end

	def self.total_number_of_dogs #Adding self before method name, this method becames a class method
		@@number_of_dogs
	end

	def self.what_am_i
		"I am a GoodDog class!"
	end
end

puts GoodDog.what_am_i

dog1 = GoodDog.new
dog2 = GoodDog.new


puts dog1.total_number_of_dogs