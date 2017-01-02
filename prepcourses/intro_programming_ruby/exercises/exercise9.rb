#1. Get the value of key `:b`.

#2. Add to this hash the key:value pair `{e:5}`

#3. Remove all key:value pairs whose value is less than 3.5

h = {a:1, b:2, c:3, d:4}

puts "1. Getting the value of b: #{h[:b]}"
h[:e] = 5
puts "2. Adding the key:value pair {e:5} doing h[:e] = 5"
p h

puts "3. Removing all key:value paris whose value is less than 3.5"
h.select! { |key, value| value > 3.5 }
p h