require 'pry'

def prompt(message)
  puts "=> #{message}"
end

def valid_name?(name)
  !name.empty?
end

def number?(number)
  number.to_f.to_s == number || number.to_i.to_s == number
end

def positive_float?(value)
  number?(value) && value.to_f > 0
end

def positive_integer?(value)
  number?(value) && value.to_i > 0
end

def positive_number?(value)
  positive_float?(value) || positive_integer?(value)
end

def apr_is_not_negative?(apr)
  number?(apr) && apr.to_i >= 0
end

def valid_duration?(duration)
  duration.to_i.to_s == duration &&
    duration.to_i > 0
end

def valid_answer?(answer)
  %w(y n).include?(answer.downcase)
end

def no_apr_mortgage(loan, duration)
  loan.to_f / duration.to_i
end

def positive_apr_mortgage(loan, apr, duration)
  monthy_interest_rate = (apr.to_f / 100) / 12
  loan.to_f * (monthy_interest_rate /
    (1 - (1 + monthy_interest_rate)**-duration.to_i))
end

def calculate_mortgage_rate(loan, apr, duration)
  if apr.to_i.zero?
    no_apr_mortgage(loan, duration)
  else
    positive_apr_mortgage(loan, apr, duration)
  end
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
    if apr_is_not_negative?(annual_percentage_rate)
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

  mortage = calculate_mortgage_rate(loan,
                                    annual_percentage_rate,
                                    loan_duration_in_months)

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
