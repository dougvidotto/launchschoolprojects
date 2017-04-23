module Messages
  def display_message(msg)
    puts "=> #{msg}"
  end
end

module Board

  attr_accessor :piece_positions

  def display
    puts ""
    puts "     |     |"
    puts "  X  |     |"
    puts "     |     |"
    puts "_____|_____|_____"
    puts "     |     |"
    puts "     |     |  X"
    puts "     |     |"
    puts "_____|_____|_____"
    puts "     |     |"
    puts "     |     |"
    puts "     |     |"
    puts ""
  end
  
end

class Piece
  def initialize(piece_type)
    @piece_type = piece_type
  end
end



class Player
  attr_accessor :name,
                :piece

  def initialize(name, piece_type)
    @name = name
    @piece = piece_type
  end

  def mark(board)

  end
end

class Computer < Player
  def mark

  end
end

class Game
  include Messages
  
  attr_accessor :player,
                :computer,
                :board

  def welcome_message
    display_message("Welcome to Tic Tac Toe!")
  end

  def ask_for_player_name
    player_name = ""
    loop do
      display_message("Please insert your name: ")
      player_name = gets.chomp
      break unless player_name == ""
      display_message("Sorry. You have to input a name.")
    end
    player_name
  end

  def ask_for_player_piece
    player_piece = ""
    loop do
      display_message("Which piece would you like to play with? O or X?")
      player_piece = gets.chomp
      break if %w(o x).include?(player_piece.downcase) 
      display_message("Sorry. That's not a valid option.")
    end
    player_piece
  end

  def create_board
    self.board = Board.new
  end

  def create_computer

  end

  def create_player
    player_name = ask_for_player_name
    player_piece = ask_for_player_piece
    self.player = Player.new(player_name, player_piece)
  end

  def play
    welcome_message
    create_player
    create_computer
    create_board
    board.display
  end
end

Game.new.play