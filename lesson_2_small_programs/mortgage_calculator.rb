def prompt(message)
  puts "=> #{message}"
end

def valid_name?(name)
  if name.empty?
    false
  else
    true
  end
end

def valid_number?(loan)
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

def valid_answer?(answer)
  if answer.casecmp("y").zero? ||
     answer.casecmp("n").zero?
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
    if valid_name?(name)
      break
    else
      prompt("Invalid name. Please try again.")
      name = gets.chomp.strip
    end
  end

  prompt("#{name}, please insert a loan amount:")
  loan = gets.chomp.strip

  loop do
    if valid_number?(loan)
      break
    else
      prompt("Invalid value for loan. Please try again")
      loan = gets.chomp.strip
    end
  end

  prompt("#{name}, please insert the APR amount (only numbers) :")
  annual_percentage_rate = gets.chomp.strip

  loop do
    if valid_number?(annual_percentage_rate)
      break
    else
      prompt("Invalid value for annual_percentage_rate. Please try again")
      annual_percentage_rate = gets.chomp.strip
    end
  end

  prompt("#{name}, please insert the loan duration in months:")
  loan_duration_in_months = gets.chomp.strip

  loop do
    if valid_duration?(loan_duration_in_months)
      break
    else
      prompt("Invalid value for loan duration. Please try again")
      loan_duration_in_months = gets.chomp.strip
    end
  end

  monthy_interest_rate = (annual_percentage_rate.to_f / 100) / 12
  mortage = loan.to_f * (monthy_interest_rate /
            (1 - (1 + monthy_interest_rate)**-loan_duration_in_months.to_i))

  prompt("The mortage rate will be: U$ #{mortage.round(2)} per month")

  prompt("#{name}, calcula mortgage again? Type (y) for yes or (n) for no")
  answer = gets.chomp

  loop do
    if valid_answer?(answer)
      break
    else
      prompt("Invalid answer. Type 'y' or 'n'.")
      prompt("#{name}, calcula mortgage again? Type (y) for yes or (n) for no")
      answer = gets.chomp
    end
  end

  break if answer.casecmp("n").zero?
end

prompt("Thanks for using Mortage Calculator! Bye!")
