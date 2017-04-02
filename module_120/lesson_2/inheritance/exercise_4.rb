puts "What is the method lookup path and how is it important?"
puts "A: The method lookup is the order that ruby looks to decide which method to call."
puts "First ruby looks the method being called inside the class of that object. If it doesn't find, it looks inside the included modules"
puts "Then finally, it looks at the superclasses"