class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]
  def initialize
    @squares = {}
    reset
  end

  def get_square_at(key)
    @squares[key]
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def human_about_to_win(squares, human_marker)
    two_human_markers =
      (squares.count { |square| square.marker == human_marker } == 2)

    one_unmarked = (squares.count(&:unmarked?) == 1)

    two_human_markers && one_unmarked
  end

  def one_to_win(human_marker)
    squares_to_defend = []
    WINNING_LINES.each do |line|
      squares_at_winning_line = @squares.values_at(*line)
      if human_about_to_win(squares_at_winning_line, human_marker)
        squares_to_defend.push(
          line.select { |key| @squares[key].unmarked? }.first
        )
      end
    end
    squares_to_defend
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts "     |     |"
    puts "_____|_____|_____"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts "     |     |"
    puts "_____|_____|_____"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts "     |     |"
    puts ""
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "
  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :marker, :name
  attr_accessor :score

  def initialize(name, marker)
    @name = name
    @marker = marker
    @score = 0
  end

  def add_score
    @score += 1
  end

  def reset_score
    @score = 0
  end

  def to_s
    @name
  end
end

class TTTGame
  CROSS_MARKER = 'X'
  CIRCLE_MARKER = 'O'
  VICTORIES_TO_WIN = 5

  attr_reader :board, :human, :computer, :human_turn

  def initialize
    @board = Board.new
  end

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_and_display_board
    clear_screen
    display_board
  end

  def display_board
    puts "#{human} are #{human.marker}. #{computer} is #{computer.marker}"
    show_current_score
    board.draw
  end

  def joinor(unmarked_keys, separator = ', ', preposition = 'or')
    if unmarked_keys.size < 3
      unmarked_keys.join(preposition)
    else
      unmarked_keys[0..-2].join(separator) + ' ' +
        preposition + ' ' + unmarked_keys[-1].to_s
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}):"
    square = 0
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry. It's not a valid choice"
    end

    board[square] = human.marker
  end

  def place_winning_or_lose_square(squares)
    computer_winning_square = squares.sample
    board[computer_winning_square] = computer.marker
  end

  def attack_or_defend
    computer_winning_squares = board.one_to_win(computer.marker)
    human_winning_squares = board.one_to_win(human.marker)
    if !computer_winning_squares.empty?
      place_winning_or_lose_square(computer_winning_squares)
      return true
    elsif !human_winning_squares.empty?
      place_winning_or_lose_square(human_winning_squares)
      return true
    end
    false
  end

  def computer_moves
    return if attack_or_defend
    if board.unmarked_keys.include?(5)
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def plurality(score)
    score == 1 ? 'victory' : 'victories'
  end

  def show_current_score
    puts ""
    puts "#{human} has #{human.score} #{plurality(human.score)}"
    puts "#{computer} has #{computer.score} #{plurality(computer.score)}"
    puts ""
  end

  def display_result
    display_board
    case board.winning_marker
    when human.marker
      puts "You won!"
      human.add_score
    when computer.marker
      puts "Computer won!"
      computer.add_score
    else
      puts "It's a tie!"
    end
    show_current_score
    puts "Press any key to continue"
    gets
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y n].include?(answer)
      puts "Sorry, must be y or n"
    end
    answer == 'y' ? true : false
  end

  def clear_screen
    system 'clear'
  end

  def reset
    board.reset
    clear_screen
    @current_marker = human.marker
  end

  def display_play_again_message
    clear_screen
    puts "Let's play again!"
    puts ""
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def total_victories_achieved?
    human.score == VICTORIES_TO_WIN || computer.score == VICTORIES_TO_WIN
  end

  def display_end_game_result
    if human.score == VICTORIES_TO_WIN
      puts "You have #{VICTORIES_TO_WIN} victories! You beat computer!"
    else
      puts "Computer has #{VICTORIES_TO_WIN} victories. Computer beat you."
    end
    puts ""
  end

  def play_turn
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_and_display_board if human_turn?
    end
  end

  def play_round
    loop do
      reset
      display_board
      play_turn
      display_result
      break if total_victories_achieved?
    end
  end

  def ask_for_player_name
    human_name = nil
    loop do
      puts "So, what's your name?"
      human_name = gets.chomp
      break if human_name.strip != ""
      puts "Sorry, you have to choose a name"
    end
    human_name
  end

  def computer_name_is_random?
    answer = nil
    loop do
      puts ""
      puts "Would you like to give the computer a name?"
      puts "1) I would like to set one"
      puts "2) No, just choose a random one for me"
      answer = gets.chomp.to_i
      break if [1, 2].include?(answer)
      puts "Sorry, you must insert 1 or 2."
    end
    return true if answer == 2
    false
  end

  def ask_for_computer_name
    computer_name = nil
    if !computer_name_is_random?
      loop do
        puts "What is the computer name then?"
        computer_name = gets.chomp
        break if computer_name.strip != ""
        puts "Sorry, you have to choose a name"
      end
    else
      computer_name = ['Terminator', 'Mr Handy', 'David 8', 'Megazord'].sample
    end
    computer_name
  end

  def choose_cross_or_circle
    human_marker = nil
    loop do
      puts "Please, choose a marker: X or O"
      human_marker = gets.chomp
      break if %w[x o].include?(human_marker.downcase)
      puts "Sorry, invalid choice."
    end
    human_marker
  end

  def config_players
    human_name = ask_for_player_name
    computer_name = ask_for_computer_name
    human_marker = choose_cross_or_circle
    if human_marker == CROSS_MARKER.downcase
      @human = Player.new(human_name, CROSS_MARKER)
      @computer = Player.new(computer_name, CIRCLE_MARKER)
      @current_marker = CROSS_MARKER
    else
      @human = Player.new(human_name, CIRCLE_MARKER)
      @computer = Player.new(computer_name, CROSS_MARKER)
      @current_marker = CIRCLE_MARKER
    end
    human.reset_score
    computer.reset_score
  end

  public

  def play
    clear_screen
    display_welcome_message
    loop do
      config_players
      play_round
      display_end_game_result
      break unless play_again?
      display_play_again_message
    end
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
