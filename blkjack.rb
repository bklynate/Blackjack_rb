#require 'pry'

def prompt(words)
 puts ">>> #{words}"
end

def valid_choices(choice)
  choice.to_i == 1 or choice.to_i == 2
end

def user_input
  begin
    choice = gets.chomp
    prompt "Input not valid!" unless valid_choices(choice)
  end until valid_choices(choice)
  choice
end

def hand_value(cards)
 hand_value = 0
 cards.each do |cards| 
   if cards[1] == "King" or cards[1] == "Queen" or cards[1] == "Jack"
     hand_value += 10
   elsif cards[1] == "Ace"
     hand_value += 1
   else
     hand_value += cards[1]
   end
 end
 hand_value
end

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

prompt "Welcome, what is your name?"

player_name = gets.chomp.capitalize

prompt "Welcome to Nate's Blackjack"

prompt "#{player_name}'s cards are #{player_cards[0][0]} #{player_cards[0][1]} & #{player_cards[1][0]} #{player_cards[1][1]}"
prompt "The value of the cards are #{hand_value(player_cards)}"
prompt "You may 'Hit' or 'Stay': Press 1 to 'Hit' Press 2 to 'Stay'"

choice = user_input

while choice == "1"
 new_card = deck.pop
 player_cards << new_card
 prompt "#{player_name} was dealt #{new_card[0]} #{new_card[1]}"
 prompt "Your current hand total is: #{hand_value(player_cards)}"
 if hand_value(player_cards) == 21
   prompt "Blackjack!! You Win!!"
   break
 elsif hand_value(player_cards) < 21
   prompt "You may 'Hit' or 'Stay': Press 1 to 'Hit' Press 2 to 'Stay'"
   choice = gets.chomp
 else
   prompt "You Busted!! - You Lose!"
   break
 end
end

prompt "The Dealer's cards are #{dealer_cards[0][0]} #{dealer_cards[0][1]} & #{dealer_cards[1][0]} #{dealer_cards[1][1]}"
prompt "The value of the cards are #{hand_value(dealer_cards)}"

while choice == '2'
 new_card = deck.pop
 dealer_cards << new_card
 prompt "Dealer was dealt #{new_card[0]} #{new_card[1]}"
 prompt "Dealer's current hand total is: #{hand_value(dealer_cards)}"

 if hand_value(dealer_cards) == 21
  prompt "Dealer hits Blackjack, YOU LOSE!!!"
  elsif hand_value(dealer_cards) < 21
    new_card = deck.pop
    dealer_cards << new_card
  else
    prompt "Dealer Bust!! - You Win!!"
    break
 end
end

prompt "Press Enter to Exit."
exit = gets.chomp