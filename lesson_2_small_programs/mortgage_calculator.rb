def prompt(message)
  puts "=> #{message}"
end

def valid_name?(name)
  !name.empty?
end

def positive_float?(value)
  value.to_f.to_s == value && value.to_f > 0
end

def positive_integer?(value)
  value.to_i.to_s == value && value.to_i > 0
end

def positive_number?(amount)
  positive_float?(amount) ||  positive_integer?(amount)
end

def valid_duration?(duration)
  duration.to_i.to_s == duration &&
    duration.to_i > 0
end

def valid_answer?(answer)
  %w(y n).include?(answer.downcase)
end

prompt("Welcome to mortgage calculator!")

name = ''
loop do
  prompt("Please, enter your name: ")
  name = gets.chomp.strip
  if valid_name?(name)
    break
  else
    prompt("Invalid name. Please, try again")
  end
end

loop do
  loan = ''
  loop do
    prompt("#{name}, please insert a loan amount:")
    loan = gets.chomp.strip
    if positive_number?(loan)
      break
    else
      prompt("Invalid value for loan. Please try again")
    end
  end

  annual_percentage_rate = ''
  loop do
    prompt("#{name}, please insert the APR amount (only numbers) :")
    annual_percentage_rate = gets.chomp.strip
    if positive_number?(annual_percentage_rate)
      break
    else
      prompt("Invalid value for annual_percentage_rate. Please try again")
    end
  end

  loan_duration_in_months = ''
  loop do
    prompt("#{name}, please insert the loan duration in months:")
    loan_duration_in_months = gets.chomp.strip

    if valid_duration?(loan_duration_in_months)
      break
    else
      prompt("Invalid value for loan duration. Please try again")
    end
  end

  monthy_interest_rate = (annual_percentage_rate.to_f / 100) / 12
  mortage = loan.to_f * (monthy_interest_rate /
            (1 - (1 + monthy_interest_rate)**-loan_duration_in_months.to_i))

  prompt("The mortage rate will be: U$ #{format('%.2f', mortage)} per month")

  answer = ''
  loop do
    prompt("#{name}, calculate mortgage again? Type (y) for yes or (n) for no")
    answer = gets.chomp
    if valid_answer?(answer)
      break
    else
      prompt("Invalid answer. Type 'y' or 'n'.")
    end
  end

  break if %w(n).include?(answer.downcase)
end

prompt("Thanks for using Mortage Calculator! Bye!")
