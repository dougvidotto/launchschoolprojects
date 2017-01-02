puts 'Please insert your first name:'
first_name = gets.chomp
puts 'Please, now insert your last name:'
last_name = gets.chomp
puts 'Nice to meet you '+ first_name + ' ' + last_name

10.times do |n|
  puts first_name + ' ' + last_name
end
