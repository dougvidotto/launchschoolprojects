puts "Insert something:"
user_input = gets.chomp.to_s
while user_input.upcase != 'STOP'  
    puts "You typed #{user_input}"
    puts "Type something again:"
    user_input = gets.chomp.to_s
end