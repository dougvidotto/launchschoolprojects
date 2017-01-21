WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
FIRST_PLAYER = ['player', 'computer'].freeze

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "_____+_____+_____"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "_____+_____+_____"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def join_multiple(squares, separator=', ', connector='or')
  message = ''
  squares.each_with_index do |square, index|
    message += if index == squares.size - 1
                 "#{connector} " + square.to_s
               else
                 square.to_s + separator
               end
  end
  message
end

def joinor(squares, separator=', ', connector='or')
  case squares.size
  when 1
    squares.first.to_s
  when 2
    squares.first.to_s + " #{connector} " + squares[1].to_s
  else
    join_multiple(squares, separator, connector)
  end
end

def computer_pre_victory?(brd, line)
  brd.values_at(*line).count(COMPUTER_MARKER) == 2 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 1
end

def player_pre_victory?(brd, line)
  brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 1
end

def computer_winning_line(brd)
  WINNING_LINES.each do |line|
    return line if computer_pre_victory?(brd, line)
  end
  nil
end

def computer_about_to_win?(brd)
  WINNING_LINES.each do |line|
    return true if computer_pre_victory?(brd, line)
  end
  false
end

def computer_about_to_lose?(brd)
  WINNING_LINES.each do |line|
    return true if player_pre_victory?(brd, line)
  end
  false
end

def line_to_impede_player_victory(brd)
  WINNING_LINES.each do |line|
    return line if player_pre_victory?(brd, line)
  end
  nil
end

def get_computer_square_piece(brd, line)
  square = nil
  line.each do |position|
    if brd[position].casecmp(INITIAL_MARKER).zero?
      square = position
      break
    end
  end
  square
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square for a piece: (#{joinor(empty_squares(brd))}): "
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "This is not a valid choice! Try again."
  end

  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = ''
  if computer_about_to_win?(brd)
    line = computer_winning_line(brd)
    square = get_computer_square_piece(brd, line)
  elsif computer_about_to_lose?(brd)
    line = line_to_impede_player_victory(brd)
    square = get_computer_square_piece(brd, line)
  else
    square = brd[5] == INITIAL_MARKER ? 5 : empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
end

def place_piece!(brd, current_player)
  if current_player == 'player'
    player_places_piece! brd
  else
    computer_places_piece! brd
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def five_victories?(p_score, c_score)
  p_score == 5 || c_score == 5
end

def exit_game?
  answer = ''
  loop do
    prompt "Play again? (y or n)"
    answer = gets.chomp
    if %w(y n).include?(answer.downcase)
      break
    else
      prompt "Insert y to play again or n to exit"
    end
  end
  !answer.casecmp('y').zero?
end

def alternate_player!(current_player)
  if current_player == FIRST_PLAYER[0]
    FIRST_PLAYER[1]
  else
    FIRST_PLAYER[0]
  end
end

def define_first_player
  go_first_choice = ''
  loop do
    prompt "Who should go first?: "
    prompt "1. Player"
    prompt "2. Computer"
    prompt "3. random"
    go_first_choice = gets.chomp.to_i
    break if [1, 2, 3].include?(go_first_choice)
    prompt "Sorry, you have to choose 1, 2 or 3"
  end
  if go_first_choice == 3
    FIRST_PLAYER.sample
  else
    FIRST_PLAYER[go_first_choice - 1]
  end
end

def pause_game
  prompt "Press any key to continue..."
  gets
end

loop do
  player_score = 0
  computer_score = 0

  first_player = define_first_player
  if first_player == FIRST_PLAYER[0]
    prompt "Player goes first!"
  else
    prompt "Computer goes first"
  end

  pause_game

  loop do
    current_player = first_player
    board = initialize_board
    loop do
      display_board board
      place_piece! board, current_player
      current_player = alternate_player! current_player
      break if someone_won?(board) || board_full?(board)
    end

    display_board board

    if someone_won? board
      winner = detect_winner(board)
      prompt "#{winner} won!"
      winner == 'Player' ? player_score += 1 : computer_score += 1
      prompt "Score: Player has #{player_score}. Computer has #{computer_score}"
    else
      prompt "It's a tie!"
    end

    pause_game

    break if five_victories?(player_score, computer_score)
  end

  break if exit_game?
end

prompt "Thanks for playing Tic Tac Toe. Good Bye!"
