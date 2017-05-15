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
    puts "  Player - #{player.victories}  Dealer - #{dealer.victories}"
    puts "----------------------------------------------------"
    puts ""
  end

  def display_final_score_presentation
    puts "*****************   This round results   *****************"
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
    press_enter
  end

  def clear_screen
    system 'clear' || 'cls'
  end

  def press_enter
    puts "Press enter to continue..."
    gets
  end

  def display_dealer_busted
    puts "Dealer busted! You won this round!"
    puts ""
  end

  def display_player_busted
    puts "Sorry, you busted. Dealer won this round."
    puts ""
  end

  def display_dealer_turn
    puts "You stayed. Now it's dealer turn!"
    puts ""
    press_enter
  end

  def display_dealer_hits(number_of_hits, stayed)
    puts "Dealer hit #{number_of_hits} times #{stayed ? 'and stayed' : ''}"
    puts ""
    press_enter
  end

  def display_dealer_no_hits_and_stayed
    puts "Dealer didn't do any hits and stayed"
    puts ""
    press_enter
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
    puts "Would you like to play again?"
    puts "1) Yes"
    puts "2) No"
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
  attr_reader :score
  attr_accessor :victories

  def initialize
    @score = 0
    @victories = 0
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

  def display_participant_score
    if instance_of?(Player)
      show_current_cards
      puts "Your score is: #{score}"
    else
      show_current_cards(true)
      puts "Dealer score is: #{score}"
    end
    puts ""
  end

  def won?(other_player)
    other_player.busted? ||
      score > other_player.score && score <= 21
  end

  private

  def update_score
    regular_cards, aces = @cards.partition do |card|
      card.value != 'ace'
    end
    @score = 0
    sum_normal_cards(regular_cards)
    sum_aces(aces)
  end

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
      "#{@cards.first}  and #{@cards[1]}"
    else
      "#{@cards[0..-2].join(', ')} and #{@cards.last} "
    end
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
    @cards << card
    update_score
  end
end

class Dealer < Participant
  attr_reader :deck

  def initialize
    super
  end

  def shuffle_deck
    @deck = Deck.new
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
      current_cards << @cards.first.to_s
      current_cards << "  and unknown card"
    end
    puts current_cards
    puts ""
  end

  def achieved_stay_score?
    score >= 17
  end

  def hit
    @cards << deck.pick_top_card
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
        @cards << Card.new(card_value, suit,
                           Card::CARD_FACES[card_presentation_position])
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
  CARD_VALUES = ['2', '3', '4', '5', '6', '7',
                 '8', '9', '10', 'jack', 'queen',
                 'king', 'ace']

  CARD_FACES = ['🂢', '🂲', '🃂', '🃒',
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
    presentation.to_s
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
    display_title(player, dealer)
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

  def ask_for_player_hit_or_stay_decision
    decision = 0
    loop do
      display_title(player, dealer)
      show_players_cards
      display_deciding_message
      decision = gets.chomp.to_i
      break if [1, 2].include?(decision)
      display_wrong_decision_message
    end
    decision
  end

  def player_turn
    loop do
      decision = ask_for_player_hit_or_stay_decision
      decision == 1 ? player.hit(dealer.deal_card) : break
      break if player.busted?
    end
  end

  def dealer_turn
    display_title(player, dealer)
    display_dealer_turn
    dealer_hits_count = 0
    loop do
      break if dealer.busted? || dealer.achieved_stay_score?
      dealer.hit
      dealer_hits_count += 1
    end
    if dealer_hits_count > 0
      display_dealer_hits(dealer_hits_count, dealer.achieved_stay_score?)
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
    display_title(player, dealer)
    display_final_score_presentation
    player.display_participant_score
    dealer.display_participant_score
    evaluate_scores
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
      dealer.shuffle_deck
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
