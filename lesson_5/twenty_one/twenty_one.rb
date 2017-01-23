
heart_cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
diamonds_cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
clubs_cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
spades_cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]

cards_set = [heart_cards, diamonds_cards, clubs_cards, spades_cards]

def prompt(msg)
	puts "=> #{msg}"
end

def sum_cards_values(participant)
	total = 0
	participant.each do |card|
		if card.to_i == 0
			total += 10
		else
			total += card
		end
	end
	total
end

def hit(participant, cards_set)
	card_suit = cards_set.sample
	random_card = card_suit.sample
	participant << random_card
	card_suit.delete(random_card)
end

def start_game(participant, cards_set)
	card_suit = cards_set.sample
	2.times do
		random_card = card_suit.sample
		participant << random_card
		card_suit.delete(random_card)
	end
end

def show_participant_card_info(participant)
	"#{participant.join(', ')}. Total value: #{sum_cards_values(participant)}"
end

player_cards = []
dealer_cards = []

prompt "Welcome to Twenty-one game. Press any key to deal the cards..."
gets

start_game(player_cards, cards_set)
start_game(dealer_cards, cards_set)

prompt "Dealer has #{dealer_cards.first} and unknown card"
prompt "Player has #{show_participant_card_info(player_cards)}"
puts ""

choice = ''
while sum_cards_values(player_cards) <= 21
	prompt "What would you like to do? Press 1 to Hit or 2 to Stay?"
	prompt "1. Hit"
	prompt "2. Stay"
	loop do
		choice = gets.chomp.to_i
		break if [1, 2].include?(choice)
		prompt "Sorry, only 1 or 2 options are available. Try again."
	end
	if choice == 1
		hit(player_cards, cards_set)
		prompt "Player has #{show_participant_card_info(player_cards)}"
	elsif choice == 2
		break
	end
end

if sum_cards_values(player_cards) > 21
	prompt "You have been busted. Dealer wins."
else
	while sum_cards_values(dealer_cards) <= 17
		hit(dealer_cards, cards_set)
	end

	if sum_cards_values(dealer_cards) > 21
		prompt "Dealer has #{show_participant_card_info(dealer_cards)}"
		prompt "Dealer has been busted. Player wins!"
	else
		prompt "Final result:"
		prompt "Player: #{show_participant_card_info(player_cards)}"
		prompt "Dealer: #{show_participant_card_info(dealer_cards)}"

		if sum_cards_values(player_cards) > sum_cards_values(dealer_cards)
			prompt "Player wins!"
		elsif sum_cards_values(player_cards) < sum_cards_values(dealer_cards)
			prompt "Dealer wins!"
		else
			prompt "It's a tie"
		end
	end

end
