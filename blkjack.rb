#require 'pry'

#Game Methods

def prompt(words)
 puts ">>> #{words}"
end

def valid_choices(choice)
  choice.to_i == 1 or choice.to_i == 2
end

def user_input
  begin
    choice = gets.chomp
    prompt "Error: User input must be either '1' or '2'" unless valid_choices(choice)
  end until valid_choices(choice)
  choice
end

def hand_value(cards)
  arr = cards.map{ |value| value[1] }
  total = 0

  arr.each do |value|
    if value == 'A'
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value
    end
  end

  arr.select { |value| value == 'A'}.count.times do
    total -= 10 if total > 21
  end

  total
end


#Game Start Logistics
suits = ["Clubs :","Diamonds :","Spades :","Hearts :"]
card_values = [2,3,4,5,6,7,8,9,10,"King","Queen","Jack","Ace"]

deck = suits.product(card_values)
deck.shuffle!

player_cards = []
dealer_cards = []

player_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop
dealer_cards << deck.pop

player_total = hand_value(player_cards)
dealer_total = hand_value(dealer_cards)

prompt "Welcome, what is your name?"

player_name = gets.chomp.capitalize

prompt "Welcome to Nate's Blackjack"

prompt "#{player_name}'s cards are #{player_cards[0][0]} #{player_cards[0][1]} & #{player_cards[1][0]} #{player_cards[1][1]}"
prompt "The value of the player's cards are #{player_total}"


if player_total == 21
  prompt "#{player_name} has hit Blackjack - You Win!!" 
  exit
end

while player_total < 21
  prompt "You may 'Hit' or 'Stay': Press 1 to 'Hit' Press 2 to 'Stay'" 
  choice = user_input

  if choice == '2'
    prompt "#{player_name} chooses to stay."
    break
  end

  new_card = deck.pop
  prompt "#{player_name} was dealt #{new_card[0]} #{new_card[1]}"
  player_cards << new_card

  player_total = hand_value(player_cards)
  prompt "The value of #{player_name}'s' cards are #{player_total}" 

  if player_total == 21
    prompt "#{player_name} has hit Blackjack - You Win!!" 
    exit
  elsif player_total > 21
    prompt "#{player_name} has busted!! - #{player_name} Loses!!" 
    exit
  end
end

prompt "The Dealer's cards are #{dealer_cards[0][0]} #{dealer_cards[0][1]} & #{dealer_cards[1][0]} #{dealer_cards[1][1]}"
prompt "The value of dealer's cards are #{dealer_total}"

if dealer_total == 21
  prompt "Dealer has hit Blackjack - You Win!!" 
  exit
end

while dealer_total < 17

  new_card = deck.pop
  prompt "Dealer was dealt #{new_card[0]} #{new_card[1]}"
  dealer_cards << new_card

  dealer_total = hand_value(dealer_cards)
  prompt "The value of dealer's cards are #{dealer_total}" 

  if dealer_total == 21
    prompt "Dealer has hit Blackjack - You Lose!!" 
    exit
  elsif dealer_total < 21
    prompt "Dealer has busted!! - #{player_name} Wins!!" 
    exit
  end

end

if dealer_total < player_total
  prompt "#{player_name} Wins!!"
  exit
else
  prompt "Too bad - You Lose!!"
  exit
end
