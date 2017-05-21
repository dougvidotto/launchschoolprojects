module Messages
  def display_title(player, dealer)
    clear_screen
    puts "----------------------------------------------------"
    puts "  This is the Twenty-One Game !!"
    puts "  Beat the dealer getting as close as you can of 21!"
    puts "  The one who beat the other five times first is the winner!"
    puts "  Good Luck!"
    puts ""
    puts "  Victories: "
    puts "  Player - #{player.victories} x #{dealer.victories} - Dealer"
    puts "----------------------------------------------------"
    puts ""
  end

  def display_final_score_presentation
    puts "*****************   This round results   *****************"
    puts ""
  end

  def display_deciding_message
    puts "What would you like to do?"
    puts "Hit(h) or Stay?(s)"
  end

  def display_wrong_decision_message(options)
    puts "Sorry, only '#{options.first}' or '#{options[1]}' can be chosen."
    puts ""
  end

  def clear_screen
    system 'clear'
    system 'cls'
  end

  def press_enter
    puts "Press enter to continue..."
    gets
  end

  def display_dealer_busted
    puts "Dealer busted! You won this round!"
  end

  def display_player_busted
    puts "Sorry, you busted. Dealer won this round."
  end

  def display_dealer_turn
    puts "You stayed. Now it's dealer turn!"
    puts ""
  end

  def display_dealer_hits(number_of_hits, stayed)
    puts "Dealer hit #{number_of_hits} times #{stayed ? 'and stayed' : ''}"
    puts ""
  end

  def display_dealer_no_hits_and_stayed
    puts "Dealer didn't do any hits and stayed"
    puts ""
  end

  def display_player_victory(dealer_busted)
    if dealer_busted
      display_dealer_busted
    else
      puts "You got a greater score! You won this round."
    end
    puts ""
    press_enter
  end

  def display_dealer_victory(player_busted)
    if player_busted
      display_player_busted
    else
      puts "Sorry. Dealer has a greater score. Dealer won this round."
    end
    puts ""
    press_enter
  end

  def display_tie
    puts "It's a tie"
    press_enter
  end

  def display_plain_again_message
    puts "Would you like to play again? Yes(y), No(n)"
  end

  def display_player_won_match
    puts "You got 5 victories! Congratulations! You beat dealer!"
    puts ""
  end

  def display_dealer_won_match
    puts "Dealer got 5 victories! Sorry, but dealer beat you."
    puts ""
  end

  def display_good_bye_message
    puts "Thank you for playing Twenty-One! Good bye!"
  end
end

class Participant
  attr_accessor :victories

  def initialize
    @score = 0
    @cards = []
    @victories = 0
  end

  def discard_hand
    @cards = [] unless @cards.empty?
  end

  def hit(card)
    @cards << card
  end

  def busted?
    current_score > 21
  end

  def display_participant_score
    if instance_of?(Player)
      show_current_cards
    else
      show_current_cards(true)
    end
  end

  def current_score
    regular_cards, aces = @cards.partition do |card|
      card.value != 'Ace'
    end
    @score = 0
    sum_normal_cards(regular_cards)
    sum_aces(aces)
  end

  def won?(other_player)
    other_player.busted? ||
      current_score > other_player.current_score && current_score <= 21
  end

  private

  def sum_normal_cards(regular_cards)
    regular_cards.each do |card|
      @score += card.value.to_i != 0 ? card.value.to_i : 10
    end
  end

  def sum_aces(aces)
    total = 0
    1.upto(aces.size) do |_|
      total += total + 11 > 21 ? 1 : 11
    end
    @score += @score + total > 21 ? aces.size : total
  end

  def display_cards
    if @cards.size == 2
      "#{@cards.first} and #{@cards[1]}"
    else
      "#{@cards[0..-2].join(', ')} and #{@cards.last}"
    end
  end
end

class Player < Participant
  def initialize
    super
  end

  def show_current_cards
    puts "You have #{display_cards} - Total: #{current_score}"
    puts ""
  end
end

class Dealer < Participant
  def initialize
    super
  end

  def show_current_cards(show_all_cards)
    current_cards = "Dealer has "
    if show_all_cards
      current_cards << display_cards
      current_cards << " - Total: #{current_score}"
    else
      current_cards << @cards.first.to_s
      current_cards << " and unknown card"
    end
    puts current_cards
    puts ""
  end

  def achieved_stay_score?
    current_score >= 17
  end
end

class Deck
  attr_accessor :cards

  def build_deck
    @cards = []
    Card::CARD_VALUES.each do |card_value|
      Card::SUITS.each do |suit|
        @cards << Card.new(card_value, suit)
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
  CARD_VALUES = ['2', '3', '4', '5', '6', '7',
                 '8', '9', '10', 'Jack', 'Queen',
                 'King', 'Ace']

  attr_reader :value

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    value
  end
end

class Game
  include Messages

  attr_reader :player, :dealer, :deck

  def initialize
    @dealer = Dealer.new
    @player = Player.new
    @deck = Deck.new
  end

  def start_playing
    display_title(player, dealer)
    play_match
    display_good_bye_message
  end

  private

  def deal_initial_cards
    player.discard_hand
    dealer.discard_hand
    2.times { |_| player.hit(deck.pick_top_card) }
    2.times { |_| dealer.hit(deck.pick_top_card) }
  end

  def show_players_cards
    dealer.show_current_cards(false)
    player.show_current_cards
  end

  def ask_for_player_hit_or_stay_decision
    decision = nil
    display_title(player, dealer)
    show_players_cards
    loop do
      display_deciding_message
      decision = gets.chomp
      break if ['h', 's'].include?(decision.downcase)
      display_wrong_decision_message(['h', 's'])
    end
    decision
  end

  def player_turn
    loop do
      decision = ask_for_player_hit_or_stay_decision
      decision.downcase == 'h' ? player.hit(deck.pick_top_card) : break
      break if player.busted?
    end
  end

  def make_dealer_hits
    quantity_of_hits = 0
    loop do
      break if dealer.busted? || dealer.achieved_stay_score?
      dealer.hit(deck.pick_top_card)
      quantity_of_hits += 1
    end
    quantity_of_hits
  end

  def dealer_turn
    display_title(player, dealer)
    display_dealer_turn
    quantity_of_hits = make_dealer_hits
    if quantity_of_hits > 0
      display_dealer_hits(quantity_of_hits, dealer.achieved_stay_score?)
    else
      display_dealer_no_hits_and_stayed
    end
  end

  def evaluate_scores
    if player.won?(dealer)
      player.victories += 1
      display_player_victory(dealer.busted?)
    elsif dealer.won?(player)
      dealer.victories += 1
      display_dealer_victory(player.busted?)
    else
      display_tie
    end
  end

  def display_result
    display_final_score_presentation
    player.display_participant_score
    dealer.display_participant_score
    evaluate_scores
  end

  def play_again?
    answer = 0
    loop do
      display_plain_again_message
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      display_wrong_decision_message(['y', 'n'])
    end
    answer.downcase == 'y'
  end

  def evaluate_end_of_match_result
    display_title(player, dealer)
    player.victories == 5 ? display_player_won_match : display_dealer_won_match
  end

  def someone_won?
    player.victories == 5 || dealer.victories == 5
  end

  def play_round
    loop do
      display_title(player, dealer)
      deck.build_deck
      deck.shuffle!
      deal_initial_cards
      player_turn
      dealer_turn unless player.busted?
      display_result
      break if someone_won?
    end
  end

  def play_match
    loop do
      player.victories = 0
      dealer.victories = 0
      play_round
      evaluate_end_of_match_result
      break unless play_again?
    end
  end
end

Game.new.start_playing
