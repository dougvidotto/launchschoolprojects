class Move
  def scissors?
    self.class == Scissors.new.class
  end

  def rock?
    self.class == Rock.new.class
  end

  def paper?
    self.class == Paper.new.class
  end

  def lizard?
    self.class == Lizard.new.class
  end

  def spock?
    self.class == Spock.new.class
  end
end

class Rock <  Move
  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def <(other_move)
    other_move.paper? || other_move.spock?
  end

  def to_s
    "Rock"
  end
end

class Paper < Move
  def >(other_move)
    other_move.rock? || other_move.spock? 
  end

  def <(other_move)
    other_move.scissors? ||other_move.lizard?
  end

  def to_s
    "Paper"
  end
end

class Scissors < Move
  def >(other_move)
    other_move.paper? || other_move.lizard?
  end

  def <(other_move)
    other_move.rock? || other_move.spock?
  end

  def to_s
    "Scissors"
  end
end

class Lizard < Move
  def >(other_move)
    other_move.spock? || other_move.paper?
  end

  def <(other_move)
    other_move.rock? || other_move.scissors?
  end

  def to_s
    "Lizard"
  end
end

class Spock < Move
  def >(other_move)
    other_move.rock? || other_move.scissors?
  end

  def <(other_move)
    other_move.lizard? || other_move.paper?
  end

  def to_s
    "Spock"
  end
end

class Player
  AVAILABLE_MOVES = [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new]

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
      break if choice > 0 && AVAILABLE_MOVES[choice - 1] != nil
      puts "Sorry, invalid choice."
    end
    self.move = AVAILABLE_MOVES[choice - 1]
  end
end

class Computer < Player
  def set_name
    self.name = ['R2', 'Hal', 'Chappie', 'Sony', 'Number 5'].sample
  end

  def choose
    self.move = AVAILABLE_MOVES[rand(5)]
  end
end

class Rules
  def match(history)

  end
end

class HistoryOfMovements
  attr_accessor :human_moves, :computer_moves, :human_matches, :computer_matches

  def initialize
    @human_moves = []
    @computer_moves = []
    @human_matches = Hash.new([])
    @computer_matches = Hash.new([])
  end

  def add_human_move(move)
    self.human_moves.push(move)
  end

  def add_computer_move(move)
    self.computer_moves.push(move)
  end

  def add_victory_to_human(move)
    human_matches["win"].push(move)
  end

  def add_defeat_to_human(move)
    human_matches["lose"].push(move)
  end

  def add_victory_to_computer(move)
    computer_matches["win"].push(move)
  end

  def add_defeat_to_computer(move)
    computer_matches["lose"].push(move)
  end

  def show_human_moves
    self.human_moves.join(",")
  end

  def show_computer_moves
    self.computer_moves.join(",")
  end
end

class RPSGame
  attr_accessor :human, :computer, :max_score, :history_of_movements

  def initialize
    @human = Human.new
    @computer = Computer.new
    @history_of_movements = HistoryOfMovements.new
  end

  def register_history
    history_of_movements.add_human_move(human.move)
    history_of_movements.add_computer_move(computer.move)
  end

  def display_moves
    puts "#{human} chose #{human.move}."
    puts "#{computer} chose #{computer.move}."
  end

  def evaluate_the_winner
    if human.move > computer.move
      puts "#{human} won!"
      human.current_score += 1
      history_of_movements.add_victory_to_human(human.move)
    elsif human.move < computer.move
      puts "#{computer} won!"
      computer.current_score += 1
      history_of_movements.add_victory_to_computer(computer.move)
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
    puts "-------- Player needs #{max_score} victories to win! ---------------"
    puts "#{human} movements so far: #{history_of_movements.show_human_moves}"
    puts "#{computer} movements so far: #{history_of_movements.show_computer_moves}"
    puts ""
    puts "#{human} has #{human.current_score} #{(human.current_score == 1) ? 'victory' : 'victories'}" 
    puts "#{computer} has #{computer.current_score} #{(computer.current_score == 1) ? 'victory' : 'victories'}"
    puts "---------------------------------------------------------------"
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
      display_current_situation
      human.choose
      computer.choose
      register_history
      display_moves
      evaluate_the_winner
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
