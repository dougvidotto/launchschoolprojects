puts "Insert a number to be found:"
chosen_number = gets.chomp.to_i

arr = [1, 3, 5, 7, 9, 11]

if(arr.include?(chosen_number))
  puts "The number you have chosen is in the list: #{chosen_number}"
else
  puts "Sorry, your number is not in the list"
end