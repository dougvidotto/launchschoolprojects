class Player
  attr_accessor :move, :name, :current_score
  def initialize
    set_name
  end

  def to_s
    @name
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose:"
      puts "1) Rock"
      puts "2) Paper"
      puts "3) Scissors"
      puts "4) Lizard"
      puts "5) Spock"
      choice = gets.chomp.to_i
      break if choice > 0 && Move::VALUES[choice - 1] != nil
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice - 1)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2', 'Hal', 'Chappie', 'Sony', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(rand(5))
  end
end

class Move
  VALUES = %w[rock paper scissors lizard spock]

  def initialize(value)
    @value = VALUES[value]
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?) ) ||
      (paper? && (other_move.rock? || other_move.spock?) ) ||
      (scissors? && (other_move.paper? || other_move.lizard?) ) ||
      (lizard? && (other_move.spock? || other_move.paper?) ) ||
      (spock? && (other_move.rock? || other_move.scissors?) )
  end

  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?) ) ||
      (paper? && (other_move.scissors? ||other_move.lizard?) ) ||
      (scissors? && (other_move.rock? || other_move.spock?) ) ||
      (spock? && (other_move.lizard? || other_move.paper?) ) ||
      (lizard? && (other_move.rock? || other_move.scissors?) )
  end

  def to_s
    @value
  end
end

class RPSGame
  attr_accessor :human, :computer, :max_score

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_moves
    puts "#{human} chose #{human.move}."
    puts "#{computer} chose #{computer.move}."
  end

  def display_match_winner
    if human.move > computer.move
      puts "#{human} won!"
      human.current_score += 1
    elsif computer.move > human.move
      puts "#{computer} won!"
      computer.current_score += 1
    else
      puts "It's a tie."
    end
  end

  def display_champion
    if human.current_score > computer.current_score
      puts "#{human} achieved #{max_score} first! #{human} is the champion!"
    else
      puts "#{computer} achieved #{max_score} first! #{computer} is the champion!"
    end
  end

  def display_current_situation
    puts "-------- Player needs #{max_score} victories to win! --------"
    puts "#{human} has #{human.current_score} #{(human.current_score == 1) ? 'victory' : 'victories'}" 
    puts "#{computer} has #{computer.current_score} #{(computer.current_score == 1) ? 'victory' : 'victories'}"
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard and Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard and Spock! Good Bye!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if %w[y n].include? answer.downcase
      puts "Sorry, you have to choose (y/n)"
    end
    return true if answer == 'y'
    false
  end

  def ask_for_score
    puts "How many victories a player should get to win?"
    score = 0
    loop do
      score = gets.chomp.to_i
      break if score > 0
      puts "Invalid choice. Please insert a value greater than 0."
    end
    self.max_score = score
  end

  def initial_configurations
    ask_for_score
    human.current_score = 0
    computer.current_score = 0
  end

  def play_match
    loop do
      system "clear"
      human.choose
      computer.choose
      display_moves
      display_match_winner
      display_current_situation
      puts "Press any key to continue"
      gets.chomp
      break if human.current_score == self.max_score || computer.current_score == self.max_score
    end
  end

  def play
    display_welcome_message
    loop do
      initial_configurations  
      play_match
      display_champion
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
