require 'pry'

module Messages
  def display_title
    puts "----------------------------------------------------"
    puts "         This is the Twenty-One Game !!             "
    puts "  Beat the dealer getting as close as you can of 21!"
    puts "  Good Luck!"
    puts "----------------------------------------------------"
  end

  def display_deciding_message
    puts "What would you like to do?"
    puts "1) Hit"
    puts "2) Stay"
    puts ""
  end

  def display_wrong_decision_message
    puts "Sorry, you must choose 1 or 2. Please, try again."
    puts ""
  end

  def clear_screen
    system 'clear' || 'cls'
  end

  def press_any_key
    puts "Press any key to continue..."
    gets
  end

  def display_dealer_busted
    puts "Dealer busted! You win!"    
  end

  def display_player_busted
    puts "Sorry, you busted. Dealer wins."    
  end

  def display_dealer_turn
    puts "Dealer turn!"
    puts ""
  end

  def display_dealer_hit
    puts "Dealer hit..."
    puts ""
    press_any_key
  end

  def display_player_victory
    puts "Congratulations! You got a greater score! You won!"
    press_any_key
  end

  def display_dealer_victory
    puts "Sorry. Dealer has a greater score. Dealer won."
    press_any_key
  end
end

class Participant
  attr_accessor :cards, :score

  def initialize
    @score = 0
    @cards = []
  end

  def receive_initial_cards(initial_cards)
    cards << initial_cards.first
    cards << initial_cards[1]
    update_score
  end

  def busted?
    score > 21
  end

  private

  def update_score
    normal_cards, aces = cards.partition do |card|
      card.value != 'ace'
    end
    self.score = 0
    sum_normal_cards(normal_cards)
    sum_aces(aces)
  end


  def sum_normal_cards(normal_cards)
    normal_cards.each do |card|
      card.value.to_i != 0 ? self.score += card.value.to_i : self.score += 10
    end
  end

  def sum_aces(aces)
    total = 0
    1.upto(aces.size) do |_|
      total + 11 > 21 ? total += 1 : total += 11
    end
    score + total > 21 ? self.score += aces.size : self.score += total
  end

  def display_cards
    cards.size == 2 ? "#{cards.first} and #{cards[1]}" : "#{cards[0..-2].join(', ')} and #{cards.last}"
  end
end

class Player < Participant
  def initialize
    super
  end

  def show_current_cards
    puts "You have #{display_cards}"
  end

  def achieved_twenty_one?
    score == 21
  end

  def hit(card)
    cards << card
    update_score
  end
end

class Dealer < Participant
  attr_reader :deck

  def initialize
    @deck = Deck.new
    super
  end

  def shuffle_deck
    deck.shuffle!
  end

  def deal_initial_cards
    [deck.pick_top_card, deck.pick_top_card]
  end

  def deal_card
    deck.pick_top_card
  end

  def show_current_cards(show_all_cards)
    current_cards = "Dealer has "
    if show_all_cards
      current_cards << display_cards
    else
      current_cards << cards.first.to_s
      current_cards << " and unknown card"
    end
    puts current_cards
  end

  def achieved_seventeen?
    score >= 17
  end

  def hit
    cards << deck.pick_top_card
    update_score
  end
end

class Deck
  attr_accessor :cards

  def initialize
    build_deck
  end

  def build_deck
    @cards = []
    Card::SUITS.each do |suit|
      Card::CARD_VALUES.each do |card_value|
        @cards.push(Card.new(card_value, suit))
      end
    end
  end

  def shuffle!
    cards.shuffle!
  end

  def pick_top_card
    cards.shift
  end
end

class Card
  SUITS = ['HEARTS', 'DIAMONDS', 'CLUBS', 'SPADES']
  CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']

  attr_reader :value

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "#{@value}"
  end
end

class Game
  include Messages

  attr_reader :player, :dealer

  def initialize
    @dealer = Dealer.new
    @player = Player.new
  end

  def deal_initial_cards
    player.receive_initial_cards(dealer.deal_initial_cards)
    dealer.receive_initial_cards(dealer.deal_initial_cards)
  end

  def show_players_cards
    dealer.show_current_cards(false)
    player.show_current_cards
  end

  def player_turn
    decision = 0
    loop do
      show_players_cards
      break if player.busted? || player.achieved_twenty_one?
      display_deciding_message
      decision = gets.chomp.to_i
      break if decision == 2
      decision == 1 ? player.hit(dealer.deal_card) : display_wrong_decision_message
    end
  end

  def dealer_turn
    clear_screen
    display_title
    display_dealer_turn
    loop do
      show_players_cards
      break if dealer.busted? || dealer.achieved_seventeen?
      display_dealer_hit
      dealer.hit
    end
  end

  def show_player_score
    player.show_current_cards
    puts "Your score is: #{player.score}"
    puts ""
  end

  def show_dealer_score
    dealer.show_current_cards(true)
    puts "Dealer score is: #{dealer.score}"
    puts ""
  end

  def someone_busted?
    if player.busted?
      display_player_busted
      return true
    end

    if dealer.busted?
      display_dealer_busted
      return true
    end
    false
  end

  def evaluate_scores
    clear_screen
    display_title
    show_player_score
    show_dealer_score
    if !someone_busted?
      player.score > dealer.score ? display_player_victory : display_dealer_victory
    end
  end

  def start_playing
    clear_screen
    display_title
    press_any_key
    loop do
      clear_screen
      display_title
      dealer.shuffle_deck
      deal_initial_cards
      player_turn
      break if player.busted?
      dealer_turn
      break
    end
    evaluate_scores
  end
end

Game.new.start_playing
