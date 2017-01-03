# Ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(number)
  if number.to_f.to_s == number || number.to_i.to_s == number
    true
  else
    false
  end
end

def operator_to_message(operator)
  case operator
  when '1'
    "Adding"
  when '2'
    "Subtracting"
  when '3'
    "Multiplying"
  when '4'
    "Dividing"
  end
end

def convert_to_number(str_number)
  if str_number.include?('.')
    str_number.to_f
  else
    str_number.to_i
  end
end

prompt("Welcome to calculator!")

prompt("Please enter your name: ")
name = gets().chomp()

loop do
  if name.empty?
    prompt("Please, enter a valid name: ")
    name = gets().chomp()
  else
    break
  end
end

loop do
  prompt("#{name}, please, enter the first number:")
  number1 = Kernel.gets().chomp()

  loop do
    if valid_number?(number1)
      break
    else
      prompt("Humm..it doesnt look like a valid number")
      number1 = Kernel.gets().chomp()
    end
  end

  prompt("#{name}, please, enter the second number")
  number2 = Kernel.gets().chomp()

  loop do
    if valid_number?(number2)
      break
    else
      prompt("Humm..it doesnt look like a valid number")
      number2 = Kernel.gets().chomp()
    end
  end

  operator_prompt = <<-MSG
  What operation would you like to perform?
  1) add
  2) subtract
  3) multiply
  4) divide
  MSG
  prompt(operator_prompt)
  operator = Kernel.gets().chomp()

  loop do
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Operator must be 1, 2, 3 or 4")
      operator = Kernel.gets().chomp()
    end
  end

  prompt("#{operator_to_message(operator)} these two numbers...")
  result = case operator
           when '1'
             convert_to_number(number1) + convert_to_number(number2)
           when '2'
             convert_to_number(number1) - convert_to_number(number2)
           when '3'
             convert_to_number(number1) * convert_to_number(number2)
           when '4'
             number1.to_f() / number2.to_f()
           end
  prompt("The result is #{result}")

  prompt("Do you want to calculate again? (Y) for calculate.")
  answer = gets().chomp()

  break if answer.downcase.to_s != 'y'
end

prompt("Thank you for using calculator. Good Bye!")
