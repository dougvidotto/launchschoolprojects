# A module is similar to a class, but instead it doesn't have state and can't be instantied.
# It has a set of behaviors that can be distributed to other classes
# To create a module we do as below:

module Ring
	def ring(ring_tone)
		puts "#{ring_tone}"
	end
end

class Smartphone
	include Ring
end

galaxy = Smartphone.new
galaxy.ring("Trrrrriiiiiimmmmmmmmm")