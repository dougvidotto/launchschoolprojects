class Person
	
	attr_accessor :first_name, :last_name
	
	def initialize(full_name)
		parse_full_name(full_name)
	end

	def name=(full_name)
		parse_full_name(full_name)
	end

	def parse_full_name(full_name)
		names = full_name.split
		first_name = names.first
		last_name = names.size > 1 ? names.last : ""
	end

	def name
		"#{first_name} #{last_name}".strip
	end

	def ==(another_person)
		self.name == another_person.name
	end

	def to_s
		name
	end
end

# What would the following code print?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

puts "Answer:"
puts "The code would print the name of the class plus a lot of hexadecimal code in the screen"
puts "If we want it to print something more readable, we must override to_s method"