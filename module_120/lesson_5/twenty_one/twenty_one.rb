module Messages
  def display_title
    clear_screen
    puts "----------------------------------------------------"
    puts "  This is the Twenty-One Game !!"
    puts "  Beat the dealer getting as close as you can of 21!"
    puts "  Good Luck!"
    puts "----------------------------------------------------"
    puts ""
  end

  def display_final_score_presentation
    puts "Final Results:"
    puts ""
  end

  def display_deciding_message
    puts "What would you like to do?"
    puts "1) Hit"
    puts "2) Stay"
  end

  def display_wrong_decision_message
    puts "Sorry, you must choose 1 or 2. Please, try again."
    puts ""
  end

  def clear_screen
    system 'clear' || 'cls'
  end

  def press_any_key
    puts "Press enter to continue..."
    gets
  end

  def display_dealer_busted
    puts "Dealer busted! You win!"
    puts ""
  end

  def display_player_busted
    puts "Sorry, you busted. Dealer wins."
    puts ""
  end

  def display_dealer_turn
    puts "You stayed. Now it's dealer turn!"
    puts ""
    press_any_key
  end

  def display_dealer_hits(number_of_hits, stayed)
    puts "Dealer hit #{number_of_hits} times #{stayed ? 'and stayed' : ''}"
    puts ""
    press_any_key
  end

  def display_dealer_no_hits_and_stayed
    puts "Dealer didn't do any hits and stayed"
    press_any_key
  end

  def display_player_victory
    puts "Congratulations! You got a greater score! You won!"
    puts ""
    press_any_key
  end

  def display_dealer_victory
    puts "Sorry. Dealer has a greater score. Dealer won."
    puts ""
    press_any_key
  end

  def display_tie
    puts "It's a tie"
    press_any_key
  end

  def display_plain_again_message
    puts "Would you like to play again?"
    puts "1) Yes"
    puts "2) No"
  end

  def display_good_bye_message
    puts "Thank you for playing Twenty-One! Good bye!"
  end
end

class Participant
  attr_accessor :cards
  attr_reader :score

  def initialize
    @score = 0
  end

  def receive_initial_cards(initial_cards)
    @cards = []
    @cards << initial_cards.first
    @cards << initial_cards[1]
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
    @score = 0
    sum_normal_cards(normal_cards)
    sum_aces(aces)
  end


  def sum_normal_cards(normal_cards)
    normal_cards.each do |card|
      card.value.to_i != 0 ? @score += card.value.to_i : @score += 10
    end
  end

  def sum_aces(aces)
    total = 0
    1.upto(aces.size) do |_|
      total + 11 > 21 ? total += 1 : total += 11
    end
    score + total > 21 ? @score += aces.size : @score += total
  end

  def display_cards
    cards.size == 2 ? "#{cards.first}  and #{cards[1]}" : "#{cards[0..-2].join(', ')} and #{cards.last} "
  end
end

class Player < Participant
  def initialize
    super
  end

  def show_current_cards
    puts "You have #{display_cards}"
    puts ""
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
      current_cards << "  and unknown card"
    end
    puts current_cards
    puts ""
  end

  def achieved_stay_score?
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
    card_presentation_position = 0
    Card::CARD_VALUES.each do |card_value|
      Card::SUITS.each do |suit|
        @cards << Card.new(card_value, suit, Card::PRESENTATIONS[card_presentation_position])
        card_presentation_position += 1
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

  SUITS = ['SPADES', 'HEARTS', 'DIAMONDS', 'CLUBS']
  CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']

  PRESENTATIONS = ['🂢', '🂲', '🃂', '🃒',
                   '🂣', '🂳', '🃃', '🃓', 
                   '🂤', '🂴', '🃄', '🃔',
                   '🂥', '🂵', '🃅', '🃕',
                   '🂦', '🂶', '🃆', '🃖',
                   '🂧', '🂷', '🃇', '🃗',
                   '🂨', '🂸', '🃈', '🃘',
                   '🂩', '🂹', '🃉', '🃙',
                   '🂪', '🂺', '🃊', '🃚',
                   '🂫', '🂻', '🃋', '🃛',
                   '🂭', '🂽', '🃍', '🃝',
                   '🂮', '🂾', '🃎', '🃞',
                   '🂡', '🂱', '🃁', '🃑']

  attr_reader :value, :presentation

  def initialize(value, suit, presentation)
    @value = value
    @suit = suit
    @presentation = presentation
  end

  def to_s
    "#{@presentation}"
  end
end

class Game
  include Messages

  attr_reader :player, :dealer

  def initialize
    @dealer = Dealer.new
    @player = Player.new
  end

  def start_playing
    display_title
    play_match
    display_good_bye_message
  end

  private

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
      break if player.busted?
      display_deciding_message
      decision = gets.chomp.to_i
      break if decision == 2
      decision == 1 ? player.hit(dealer.deal_card) : display_wrong_decision_message
      display_title
    end
    clear_screen
  end 

  def dealer_turn
    display_title
    display_dealer_turn
    dealer_hits_count = 0
    loop do
      break if dealer.busted? || dealer.achieved_stay_score?
      dealer.hit
      dealer_hits_count += 1
    end
    dealer_hits_count > 0 ?
      display_dealer_hits(dealer_hits_count, dealer.achieved_stay_score?) :
      display_dealer_no_hits_and_stayed
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

  def show_scores
    show_player_score
    show_dealer_score
  end

  def evaluate_scores
    if player.score > dealer.score
      display_player_victory
    elsif player.score < dealer.score
      display_dealer_victory
    else
      display_tie
    end
  end

  def display_result
    display_title
    display_final_score_presentation
    show_scores
    if !someone_busted?
      evaluate_scores
    end
  end

  def play_again?
    answer = 0
    loop do
      display_plain_again_message
      answer = gets.chomp.to_i
      break if [1, 2].include?(answer.to_i)
      display_wrong_decision_message
    end
    answer == 1
  end

  def play_match
    loop do
      loop do        
        display_title
        dealer.shuffle_deck
        deal_initial_cards
        player_turn
        break if player.busted?
        dealer_turn
        break
      end
      display_result
      break unless play_again?
    end
  end
end

Game.new.start_playing
