
class Move; end

class Paper < Move
  def beat(another_move)
    another_move.class == Rock.new.class
  end
end

class Scissors < Move
  def beat(another_move)
    another_move.class == Paper.new.class
  end
end

class Rock < Move
  def beat(another_move)
    another_move.class == Scissors.new.class
  end
end

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def choose(options)
    move = nil
    loop do
      choice = gets.chomp
      move = case choice
        when 'r' then options[0]
        when 'p' then options[1]
        when 's' then options[2]
        else 'error'
      end
      break unless move == 'error'
      puts 'Wrong choice. Please type r for Rock, p for Paper or s for Scissors'
    end
    move
  end
end

class Computer_Player < Player
  def choose(options)
    options.sample
  end
end

class Game
	MOVES = [Rock.new, Paper.new, Scissors.new]

	attr_accessor :human_player, :computer_player

	def initialize(human_name)
		@human_player = Player.new(human_name)
		@computer_player = Computer_Player.new("Computer")
	end

	def start_game
		puts "Please, choose rock (r), paper (p), or scissors (s):"

		human_move = human_player.choose(MOVES)
		computer_move = computer_player.choose(MOVES)
		if human_move.beat(computer_move)
			puts "#{human_player.name} wins!"
		elsif computer_move.beat(human_move)
			puts "#{computer_player.name} wins!" 
		else
			puts "It's a tie"
		end

	end
end

Game.new("Douglas").start_game