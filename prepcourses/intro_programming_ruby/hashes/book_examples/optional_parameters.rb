def greetings(name, options = {})
  
  if options.empty?
    puts "Hi, my name is #{name}"
  else
    puts "Hi, my name is #{name}, and I am #{options[:age]} and I live in #{options[:city]}"
  end

end

def greetings_different(name, options = [])
  puts name
  puts options
end

greetings('Douglas', {age: 32, city: 'São Paulo'})
greetings_different('Paty')