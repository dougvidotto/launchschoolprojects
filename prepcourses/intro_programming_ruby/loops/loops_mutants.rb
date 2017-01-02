def mutate(arr)
  arr.pop
end

def no_mutate(arr)
  arr.select {|item| item > 4}
end

simple_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

mutate simple_array
no_mutate simple_array

puts simple_array