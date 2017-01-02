a = [1, 2, 3]

def mutate(array)
  array.pop
end

def no_mutate(array)
  array.last
end

p "Before mutated method: #{a}"
mutate(a)
p "After mutated method: #{a}"

p "Before no_mutated method: #{a}"
no_mutate(a)
p "After no_mutated method: #{a}"