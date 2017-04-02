class Vehicle
	attr_accessor :color
	attr_reader :year

	def initialize(year, color, model)
		@year = year
		@color = color
		@model = model
		@speed = 0
	end

	def speed_up(velocity)
		@speed += velocity
		puts "After accelariting #{velocity}, you are running now at #{@speed} km/h"
	end

	def break(velocity)
		@speed -= velocity
		puts "After reducing #{velocity} km/h, you are now running at #{@speed} km/h"
	end

	def turn_on
		@turned_on = true
	end

	def shut_down
		@turned_on = false
		@speed = 0
	end

	def spray_paint(color)
		self.color = color
	end
end

class MyCar <  Vehicle
	VEHICLE_TYPE = "Family vehicle"
end

class MyTruck < Vehicle
	VEHICLE_TYPE = "Heavy lifting vehicle"
end

onix = MyCar.new(2017, "Black", "Onix")
puts onix.year