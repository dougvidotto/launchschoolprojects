VALID_CHOICES = { "r" => "rock",
                  "p" => "paper",
                  "sc" => "scissors",
                  "l" => "lizard",
                  "sp" => "spock" }
WINNING_TABLE = {  "rock" => %w(lizard scissors),
                   "paper" => %w(rock spock),
                   "scissors" => %w(paper lizard),
                   "lizard" => %w(paper spock),
                   "spock" => %w(rock scissors) }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def won?(player1, player2)
  WINNING_TABLE.fetch(player1).include?(player2)
end

def display_current_result(player_victories, computer_victories)
  prompt("Player: #{player_victories}. Computer: #{computer_victories}")
end

def display_results(user_choice, computer_choice)
  Kernel.puts("You chose #{user_choice}. Computer chose #{computer_choice}")
  if won?(user_choice, computer_choice)
    prompt("You won!")
  elsif won?(computer_choice, user_choice)
    prompt("Sorry, you lost")
  else
    prompt("It's a tie")
  end
end

def display_final_results(player_victories)
  if player_victories == 5
    puts("Congratulations! You beat the computer!")
  else
    puts("Sorry! Computer won!")
  end
end

def valid_answer?(answer)
  %w(y n).include?(answer.downcase)
end

loop do
  player_victories = 0
  computer_victories = 0

  while player_victories < 5 && computer_victories < 5
    choice = ''
    loop do
      prompt("Choose: (r)rock, (p)paper, (sc)scissors, (l)lizard, (sp)spock")
      choice = Kernel.gets().chomp()
      if VALID_CHOICES.key?(choice.downcase)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.values.sample
    choice = VALID_CHOICES.fetch(choice)

    if won?(choice, computer_choice)
      player_victories += 1
    elsif won?(computer_choice, choice)
      computer_victories += 1
    end

    display_results(choice, computer_choice)
    display_current_result(player_victories, computer_victories)
  end

  display_final_results(player_victories)
  answer = ''
  loop do
    prompt("Do you want to play again? Type (y) for yes or (n) for no")
    answer = gets.chomp
    if valid_answer?(answer)
      break
    else
      prompt("Invalid answer. Type 'y' or 'n'.")
    end
  end
  break if %w(n).include?(answer.downcase)
end

prompt("Thanks for playing rock, paper, scissors, lizard and spock!")
