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
  attr_reader :marker
  attr_accessor :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def add_score
    @score += 1
  end

  def reset_score
    @score = 0
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER
  VICTORIES_TO_WIN = 5

  attr_reader :board, :human, :computer, :human_turn

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
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
    puts "You are #{human.marker}. Computer is #{computer.marker}"
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

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def plurality(score)
    score == 1 ? 'victory' : 'victories'
  end

  def show_current_score
    puts ""
    puts "Human    has #{human.score} #{plurality(human.score)}"
    puts "Computer has #{computer.score} #{plurality(computer.score)}"
    puts ""
  end

  def display_result
    display_board
    case board.winning_marker
    when TTTGame::HUMAN_MARKER
      puts "You won!"
      human.add_score
    when TTTGame::COMPUTER_MARKER
      puts "Computer won!"
      computer.add_score
    else puts "It's a tie!"
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
    @current_marker = FIRST_TO_MOVE
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
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

  public

  def play
    clear_screen
    display_welcome_message
    loop do
      human.reset_score
      computer.reset_score
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
