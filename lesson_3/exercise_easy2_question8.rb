advice = "Few things in life are as important as house training your pet dinosaur."

init = advice.index("house")
advice.slice!(0, init)

puts advice

#Bonus:
advice = "Few things in life are as important as house training your pet dinosaur."
init = advice.index("house")
advice.slice(0, init)
puts "advice variable won't be changed:"
puts advice
