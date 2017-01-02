def count_down(number)
  if number == 0
    return number
  else
    puts number
    return count_down(number - 1)
  end
end

puts "Insert a number to be counted down to zero"
a_number = gets.chomp.to_i
count_down(a_number)