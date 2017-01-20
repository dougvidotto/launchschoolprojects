require 'pry'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
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

def join_multiple(squares, separator=', ', connector='or ')
  message = ''
  squares.each_with_index do |square, index|
    message += if index == squares.size - 1
                 connector + square.to_s
               else
                 square.to_s + separator
               end
  end
  message
end

def joinor(squares, separator=', ', connector='or ')
  case squares.size
  when 1
    squares[0].to_s
  when 2
    squares[0] + connector + squares[1].to_s
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

def line_to_imped_player_victory(brd)
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

def computer_places_piece!(brd)
  square = ''
  if computer_about_to_win?(brd)
    line = computer_winning_line(brd)
    square = get_computer_square_piece(brd, line)
  elsif computer_about_to_lose?(brd)
    line = line_to_imped_player_victory(brd)
    square = get_computer_square_piece(brd, line)
  else
    square = empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
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
    if !'w%(y n)'.include?(answer.downcase)
      prompt "Insert y to play again or n to exit"
    else
      break
    end
  end
  if answer.casecmp('n').zero?
    return true
  else
    return false
  end
end

loop do
  player_score = 0
  computer_score = 0

  loop do
    board = initialize_board

    loop do
      display_board board

      player_places_piece! board
      break if someone_won?(board) || board_full?(board)

      computer_places_piece! board
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

    break if five_victories?(player_score, computer_score)
  end

  break if exit_game?
end

prompt "Thanks for playing Tic Tac Toe. Good Bye!"
