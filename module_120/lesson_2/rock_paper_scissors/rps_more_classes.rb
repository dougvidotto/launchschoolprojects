class Move
  def scissors?
    instance_of?(Scissors)
  end

  def rock?
    instance_of?(Rock)
  end

  def paper?
    instance_of?(Paper)
  end

  def lizard?
    instance_of?(Lizard)
  end

  def spock?
    instance_of?(Spock)
  end
end

class Rock < Move
  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def <(other_move)
    other_move.paper? || other_move.spock?
  end

  def ==(another_move)
    another_move.instance_of?(Rock)
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
    other_move.scissors? || other_move.lizard?
  end

  def ==(another_move)
    another_move.instance_of?(Paper)
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

  def ==(another_move)
    another_move.instance_of?(Scissors)
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

  def ==(another_move)
    another_move.instance_of?(Lizard)
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

  def ==(another_move)
    another_move.instance_of?(Spock)
  end

  def to_s
    "Spock"
  end
end

class Player
  AVAILABLE_MOVES = [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new]

  attr_accessor :move, :current_score
  attr_writer :name

  def initialize
    name
  end

  def to_s
    @name
  end
end

class Human < Player
  def name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.strip == ""
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
      break if choice > 0 && !AVAILABLE_MOVES[choice - 1].nil?
      puts "Sorry, invalid choice."
    end
    self.move = AVAILABLE_MOVES[choice - 1]
  end
end

class Computer < Player; end

class R2D2 < Computer
  # Only Rock baby!
  AVAILABLE_MOVES = [Rock.new]

  def initialize
    self.name = "R2D2"
  end

  def choose(rules)
    self.move = rules.choose(AVAILABLE_MOVES)
  end
end

class Hal < Computer
  # Hal never plays paper. Adding more scissors to raise this move's chances
  AVAILABLE_MOVES = [Scissors.new, Scissors.new, Scissors.new, Rock.new, Lizard.new, Spock.new]
  def initialize
    self.name = "Hal"
  end

  def choose(rules)
    self.move = rules.choose(AVAILABLE_MOVES)
  end
end

# Terminators fake themselves as human, so they have the same moves as humans
class Terminator < Computer
  def initialize
    self.name = "Terminator"
  end

  def choose(rules)
    self.move = rules.choose(AVAILABLE_MOVES)
  end
end

class Rule
  attr_accessor :history

  def initialize(history_of_movements)
    @history = history_of_movements
  end

  def choose(available_moves)
    available_moves.sample
  end
end

class DefeatAvoider < Rule
  def match?
    !history.computer_matches[:lose].empty?
  end

  def choose(available_moves)
    return super(available_moves) if !match?
    most_defeated_move = find_most_defeated_move
    if !most_defeated_move.nil?
      return try_to_choose_different_move(available_moves, most_defeated_move)
    end
    super(available_moves)
  end

  private

  def try_to_choose_different_move(available_moves, most_defeated_move)
    defeated_idx = available_moves.find_index(most_defeated_move)
    random_idx = rand(available_moves.size)
    if random_idx == defeated_idx
      new_rand = rand(available_moves.size)
      # Normally it's 0.2 the chance to get the same defeated value. Now it's only 20% * 20% = 4%
      return available_moves[new_rand]
    end
    available_moves[random_idx]
  end

  def find_most_defeated_move
    defeated_moves = history.computer_matches[:lose]
    defeated_moves.each do |move|
      if defeated_moves.count(move).fdiv(defeated_moves.size) > 0.6
        return move
      end
    end
    nil
  end
end

class Aggressive < Rule
  def match?
    history.human_matches[:win].size >= 2 &&
      history.human_matches[:win].last == history.human_matches[:win][-2]
  end

  def choose(available_moves)
    return super(available_moves) if !match?
    human_victory_moves = history.human_matches[:win]
    get_stronger_than(human_victory_moves.last, available_moves) if human_victory_moves.last == human_victory_moves[-2]
  end

  private

  def get_stronger_than(move, available_moves)
    stronger_moves = available_moves.select do |other_move|
      other_move > move
    end
    !stronger_moves.empty? ? stronger_moves.sample : available_moves.sample
  end
end

class RuleEngine
  attr_accessor :all_rules

  def initialize(history_of_movements)
    @all_rules = [Aggressive.new(history_of_movements), DefeatAvoider.new(history_of_movements)]
  end

  def choose(available_moves)
    all_rules.each do |rule|
      if rule.match?
        return rule.choose(available_moves)
      end
    end
    available_moves.sample
  end
end

class HistoryOfMovements
  attr_accessor :human_moves, :computer_moves, :human_matches, :computer_matches

  def initialize
    @human_moves = []
    @computer_moves = []
    @human_matches = { win: [], lose: [] }
    @computer_matches = { win: [], lose: [] }
  end

  def add_human_move(move)
    human_moves.push(move)
  end

  def add_computer_move(move)
    computer_moves.push(move)
  end

  def add_victory_to_human(move)
    human_matches[:win].push(move)
  end

  def add_defeat_to_human(move)
    human_matches[:lose].push(move)
  end

  def add_victory_to_computer(move)
    computer_matches[:win].push(move)
  end

  def add_defeat_to_computer(move)
    computer_matches[:lose].push(move)
  end

  def clear_moves
    human_moves.clear
    computer_moves.clear
  end

  def show_human_moves
    human_moves.join(",")
  end

  def show_computer_moves
    computer_moves.join(",")
  end
end

class RPSGame
  attr_accessor :human, :computer, :max_score, :history_of_movements, :rule_engine

  def initialize
    @human = Human.new
    @computer = [R2D2.new, Hal.new, Terminator.new].sample
    @history_of_movements = HistoryOfMovements.new
    @rule_engine = RuleEngine.new(history_of_movements)
  end

  private

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
      history_of_movements.add_defeat_to_computer(computer.move)
    elsif human.move < computer.move
      puts "#{computer} won!"
      computer.current_score += 1
      history_of_movements.add_victory_to_computer(computer.move)
      history_of_movements.add_defeat_to_human(human.move)
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
    puts "#{human} has #{human.current_score} #{human.current_score == 1 ? 'victory' : 'victories'}"
    puts "#{computer} has #{computer.current_score} #{computer.current_score == 1 ? 'victory' : 'victories'}"
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
    return true if answer.downcase == 'y'
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
    history_of_movements.clear_moves
  end

  def play_match
    loop do
      system "clear"
      display_current_situation
      human.choose
      computer.choose(rule_engine)
      register_history
      display_moves
      evaluate_the_winner
      puts "Press any key to continue"
      gets.chomp
      break if human.current_score == max_score ||
               computer.current_score == max_score
    end
  end

  public

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
