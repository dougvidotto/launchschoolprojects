class MyCar

	attr_accessor :color
	attr_reader :year

	def initialize(year, color, model)
		@year = year
		@color = color
		@model = model
		@current_speed = 0
	end

	#Speed in km/h
	def speed_up(speed)
		@current_speed += speed
		puts "You accelerate the car and raise the speed in #{speed} km/h"
	end

	def current_speed
		puts "You are now going #{@current_speed} km/h"
	end

	def brake(speed)
		@current_speed -= speed
		puts "You push the brakes, slowing you car #{speed} km/h"
	end

	def shut
		@current_speed = 0
		puts "Shutting down the car..."
	end

	def spray_paint(color)
		self.color = color
	end
end

car = MyCar.new(2016, "brown", "Gol")
car.speed_up(100)
puts car.current_speed

car.brake(30)
puts car.current_speed

car.shut
puts car.current_speed

puts "Current color of the car: #{car.color}"
puts "Changing the color of the car to red"
car.color = "red"
puts "Current color of the car: #{car.color}"

puts "Changing the color using spray_paint method, using car.spray_paint('silver')"
car.spray_paint('silver')

puts "Current color of the car: #{car.color}"