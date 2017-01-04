
def prompt(message)
  puts "=> #{message}"
end

def name_valid?(name)
  if name.empty?
    false
  else
    true
  end
end

def number_valid?(loan)
  if loan.to_f.to_s == loan && loan.to_f > 0
    true
  elsif loan.to_i.to_s == loan && loan.to_i > 0
    true
  else
    false
  end
end

def valid_duration?(duration)
  if duration.to_i.to_s == duration && duration.to_i > 0
    true
  else
    false
  end
end

prompt("Welcome to mortgage calculator!")
prompt("Please, enter your name: ")
name = gets.chomp.strip

loop do
  loop do
    if name_valid?(name)
      break
    else
      prompt("You didnt insert a valid name. Please try again.")
      name = gets.chomp.strip
    end
  end

  prompt("#{name}, please insert a loan amount:")
  loan = gets.chomp.strip

  loop do
    if number_valid?(loan)
      break
    else
      prompt("You didn't insert a valid value for loan. Please try again")
      loan = gets.chomp.strip
    end
  end

  prompt("#{name}, please insert the Annual Percentage Rate amount (only numbers) :")
  annual_percentage_rate = gets.chomp.strip

  loop do
    if number_valid?(annual_percentage_rate)
      break
    else
      prompt("You didn't insert a valid value for annual_percentage_rate. Please try again")
      annual_percentage_rate = gets.chomp.strip
    end
  end

  prompt("#{name}, please insert the loan duration in months:")
  loan_duration_in_months = gets.chomp.strip

  loop do
    if valid_duration?(loan_duration_in_months)
      break
    else
      prompt("You didn't insert a valid value for loan duration. Please try again")
      loan_duration_in_months = gets.chomp.strip
    end
  end

  monthy_interest_rate = (annual_percentage_rate.to_f / 100) / 12
  mortage = loan.to_f * (monthy_interest_rate / (1 - (1 + monthy_interest_rate)**-loan_duration_in_months.to_i))

  prompt("The mortage rate will be: U$ #{mortage} per month")

  prompt("#{name}, would you like to calculate another mortgage? Type (y) for yes or anything else for no")

  answer = gets.chomp

  break if answer.casecmp("y").zero?
end

prompt("Thanks for using Mortage Calculator! Bye!")
