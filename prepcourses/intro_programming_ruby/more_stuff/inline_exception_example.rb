zero = 0

puts "Before 'each' call"
zero.each { |element| puts element} rescue puts "Can't use 'each' with a zero integer"
puts "After 'each' call"