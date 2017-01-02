def numbers_0_to_100 (number)
  if (number >= 0) && (number <= 50)
    "Number is between 0 and 50"
  elsif (number > 50) && (number <= 100)
    "Number is between 51 and 100"
  else
    "Number is above 100"
  end
end

puts "Insert a number from 0 to 100"
number = gets.chomp.to_i
puts numbers_0_to_100(number)

'4' == 4 ? puts("TRUE") : puts("FALSE")