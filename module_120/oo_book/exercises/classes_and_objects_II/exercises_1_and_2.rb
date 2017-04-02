class MyCar

	attr_accessor :color
	attr_reader :year

	def self.calculate_mileage(gas, miles)
		puts "This car does #{miles/gas} miles per galon of gas"
	end

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
		@turn_on = true
	end

	def shut_down
		@turned_on = false
		@speed = 0
	end

	def spray_paint(color)
		self.color = color
	end

	def to_s
		"Model: #{@model}, Year: #{@year}, Color: #{@color}"
	end
end

hb_20 = MyCar.new(2017, "black", "Hb20")
puts hb_20

MyCar.calculate_mileage(100, 300)