a = 5

case a 
  when 5
    puts "a is 5"
  when 6
    puts "a is 6"
  else
    puts "a is #{a}"
  end

a = 11
value_of_a = case 
              when a == 5
                "Different use of case. a variable is 5"
              when a == 10
                "Now a is 10"
              else
                "Cant decide what value of a is"
              end
puts value_of_a

if ""
  puts "Empty string evaluates to true"
else
  puts "Empty string evaluates to false"
end
