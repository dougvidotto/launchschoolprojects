class Animal
	def speak
		"Generic speaking behavior"
	end

	def run
		"Running"	
	end

	def jump
		'jumping!'
	end
end

class Dog < Animal
	def speak
		"bark!"
	end

	def fetch
		'fetching!'
	end

	def swim
		'swimming!'
	end
end

class Cat < Animal
	def speak
		'meow!'
	end
end

